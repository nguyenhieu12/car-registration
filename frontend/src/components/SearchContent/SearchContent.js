import React, { useState, useRef, useEffect } from 'react';
import { utils, read } from 'xlsx';
import './SearchContent.css';
import 'boxicons/css/boxicons.min.css';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import "primereact/resources/primereact.min.css"; 
import 'boxicons/css/boxicons.min.css';
import { FilterMatchMode } from 'primereact/api';
import { InputText } from 'primereact/inputtext';
import { useReactToPrint } from 'react-to-print';
import moment from 'moment';

function SearchContent(props) {
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
    const token = localStorage.getItem('token');
    const [filters, setFilters] = useState({
        global: { value: null, matchMode: FilterMatchMode.CONTAINS },
    });
    const [autoNumber, setAutoNumber] = useState(1);
    const [registrationID, setRegistrationID] = useState({});

    const getDataVehicle = async (registration_id) => {
        fetch(`http://localhost:5000/api/v1/vehicle/details/28V29227`, {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`
          },
        })
            .then(response => response.json())
            .then(data => {
              console.log(data.data);
            })
            .catch(error => {
              console.error(error); 
            });
    };

    const [data, setData] = useState([]);

    const getData = async () => {
        fetch(`http://localhost:5000/api/v1/insp/station/2901S`, {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`
          },
        })
            .then(response => response.json())
            .then(data => {
              console.log(data.data.inspections);
              const newData = data.data.inspections.map((row, index) => ({ ...row, index: index + 1 }));
              setData(newData);
              setAutoNumber(data.length + 1)
            })
            .catch(error => {
              console.error(error); 
            });
    };

    useEffect(() => {
        // getDataVehicle("28V29227")
        getData();
    }, [])

    const handleDeleteRow = (rowData) => {
        const updatedData = data.filter((row) => row.index !== rowData.index);
        const newData = updatedData.map((row, index) => ({ ...row, index: index + 1 }));
        setData(newData);
        setAutoNumber(updatedData.length + 1); // Cập nhật số thứ tự tự động
    };

    const emptyMessage = "Cần nhập dữ liệu thông tin đăng ký xe để xử lý";

    const actionTemplate = (rowData) => {
        const handleIconClick = () => {
            if (moment(rowData.expiry_date).isBefore(moment())) {
              triggerModal(rowData);
            }
            getDataVehicle(rowData.registration_id);
          };
        return (
            <div>
                <i className="bx bx-edit-alt" onClick={handleIconClick} style={{ cursor: 'pointer' }}></i>
                <i className="bx bx-trash-alt" onClick={() => handleDeleteRow(rowData)} style={{ cursor: 'pointer', marginLeft: '0.5rem' }}></i>
            </div>
        );
    };

    const [modal, setModal] = useState(false);
    const triggerModal = (rowData) => {
        setSelectedRowData(rowData);
        setModal(!modal);
    };

    const componentRef = useRef();
    const handlePrint = useReactToPrint({
        content: () => componentRef.current,
    });

    const [selectedRowData, setSelectedRowData] = useState(null);

    return (
        <div className='searchContent-container'>
            <div className="app-container">
                <div className="app-content">
                    <div className="app-content-header">
                        <h1 className="app-content-headerText">Tra cứu xe đăng kiểm</h1>
                    </div>
                    <div className="app-content-actions">
                        <div className="search-box">
                            <i className='bx bx-search'></i>
                            <InputText
                                onInput={(e) => 
                                    setFilters({
                                        global: {value: e.target.value, matchMode: FilterMatchMode.CONTAINS}
                                    })
                                }   
                            />
                        </div>
                    </div>
                    <DataTable value={data} className="my-table" filters={filters} emptyMessage={emptyMessage} paginator rows={10} tableStyle={{ minWidth: '50rem' }}>
                    <Column field="id" header="Số thứ tự" sortable body={(rowData) => rowData.index} />
                        <Column field="inspection_id" header="Mã đăng kiểm" sortable />
                        <Column field="registration_id" header="Biển số xe" sortable />
                        <Column field="inspection_date" header="Ngày đăng kiểm" sortable body={(rowData) => moment(rowData.inspection_date).format("DD/MM/YYYY")}/>
                        <Column field='expiry_date' header='Ngày hết hạn' sortable body={(rowData) => moment(rowData.expiry_date).format("DD/MM/YYYY")}/>
                        <Column header="Trạng thái" sortable body={(rowData) => moment(rowData.expiry_date).isBefore(moment()) ? <label className='expiry'>Hết hạn</label> : <label className='unexpiry'>Đã đăng kiểm</label>}/>
                        <Column body={actionTemplate} header="" style={{ textAlign: 'center', width: '6rem' }} />
                    </DataTable>
                </div>
                <div className="container">
                    {modal && (
                        <div ref={componentRef}className="popup">
                            <div onClick={triggerModal} className="overlay"></div>
                            <div className="modal-content" id="inspection-report">
                            <form className="form">
                                {selectedRowData && (
                                    <div className='form-row-popup'>
                                        <div className='form-row-popup-item outline'>
                                            <h3>1. PHƯƠNG TIỆN <span className="big-text">(VEHICLE)</span></h3>
                                            <div className='row-flex'>
                                            <div className='row-flex-item'>
                                                <p>Biển đăng ký: {selectedRowData.registration_id}<br/>
                                                <span className="small-text">(Registration Number)</span></p>
                                            </div>
                                            <div className='row-flex-item'>
                                                <p>Số quản lý: <input type='text'/><br/>
                                                <span className="small-text">(Vehicle Inspection No.)</span></p>
                                            </div>
                                            </div>
                                            <p>Loại phương tiện: <span className="small-text">(Type)</span> {selectedRowData.type}</p>
                                            <p>Nhãn hiệu: <span className="small-text">(Mark)</span> {selectedRowData.brand}</p>
                                            <p>Số loại: <span className="small-text">(Model code)</span> {selectedRowData.model_code}</p>
                                            <p>Số khung: <span className="small-text">(Chassis Number)</span> {selectedRowData.chassis_number}</p>
                                            <div className='row-flex'>
                                            <div className='row-flex-item'>
                                                <p>Năm, Nước sản xuất: {selectedRowData.manufactured_year}, {selectedRowData.manufactured_country}<br/>
                                                <span className="small-text">(Manufactured Year and Country)</span></p>
                                            </div>
                                            <div className='row-flex-item'>
                                                <p>Năm hết niên hạn SD:<br/>
                                                <span className="small-text">(Lifetime limit to)</span></p>
                                            </div>
                                            </div>
                                            <div className='row-flex'>
                                            <p>Kinh doanh vận tải <span className="small-text">(Commercial Use)</span></p>
                                            <input type='checkbox' checked={selectedRowData.commercial_use === "True"}/>
                                            <p> Cải tạo <span className="small-text">(Modification)</span></p>
                                            <input type='checkbox'checked={selectedRowData.commercial_use === "False"}/>
                                            </div>
                                            <h3 className='margintop'>2. THÔNG SỐ KỸ THUẬT <span className="big-text">(SPECIFICATIONS)</span></h3>
                                            <div className='row-flex'>
                                            <div className='row-flex-item'>
                                                <p>Công thức bánh xe: {selectedRowData.wheel_formula}<br/>
                                                <span className="small-text">(Wheel Formula)</span></p>
                                            </div>
                                            <div className='row-flex-item'>
                                                <div className='spaceAround'>
                                                    <p>Vết bánh xe:</p> <p className="right-side">{selectedRowData.wheel_tread} (mm)</p>
                                                </div>
                                                <p><span className="small-text">(Wheel Tread)</span></p>
                                            </div>
                                            </div>
                                            <div className='spaceAround'>
                                                <p>Kích thước bao: <span className="small-text">(Overall Dismension)</span></p> <p className="right-side">{selectedRowData.overall_dimension} (mm)</p>
                                            </div>
                                            <div className='spaceAround'>
                                                <p>KT khoang hành lý lớn nhất</p> <p className="right-side">{selectedRowData.largest_luggage_container_dimension} (mm)</p>
                                            </div>
                                            <p><span className="small-text">(Langest luggage container dimension)</span></p>
                                            <div className='spaceAround'>
                                                <p>Khối lượng bản thân: <span className="small-text">(Kerb mass)</span></p> <p className="right-side">{selectedRowData.kerbmass} (mm)</p>
                                            </div>
                                            <div className='spaceAround'>
                                                <p>Khối lượng hàng CC theo TK/CP TGGT:</p> <p className="right-side">{selectedRowData.design__authorized_total_mass} (kg)</p>
                                            </div>
                                            <span className="small-text">(Design/Authorized total mass)</span>
                                            <div className='spaceAround'>
                                                <p>Khối lượng kéo theo TK/CP TGGT:</p> <p className="right-side">{selectedRowData.design__authorized_towed_mass} (kg)</p>
                                            </div>
                                            <span className="small-text">(Design/Authorized towed mass)</span>
                                            <p>Số người cho phép chở: {selectedRowData.seat} chỗ ngồi, {selectedRowData.stood_place} chỗ đứng, {selectedRowData.laying_place} chỗ nằm<br/>
                                            <span className="small-text">(Permissible No. of Pers Carried: seat, stood place, laying place)</span></p>
                                            <p>Loại nhiên liệu: <span className="small-text">(Type of Fuel Used)</span> {selectedRowData.type_of_fuel_used}</p>
                                            <div className='spaceAround'>
                                                <p>Thể tích làm việc của động cơ: <span className="small-text">(Engine Displacement)</span></p> <p className="right-side">{selectedRowData.engine_displacement} (cm3)</p>
                                            </div>
                                            <div className='spaceAround'>
                                                <p>Công suất lớn nhất/Tốc độ quay: <span className="small-text">(Max. output/rpm)</span></p> <p className="right-side">{selectedRowData.max_output} (kW)/{selectedRowData.rpm} vph</p>
                                            </div>
                                            <div className='spaceAround'>
                                                <p>Số seri: <span className="small-text">(No.)</span> <input type='text'/></p>
                                            </div>
                                            </div>
                                        <div className='form-row-popup-item outline'>
                                            <p>Số lượng lốp, cỡ lốp/trục <span className="small-text">(Number of tires, Tires size/axle)</span></p>
                                            <p>1: 2; {selectedRowData.tires_size__axle}</p>
                                            <p>2: 2; {selectedRowData.tires_size__axle}</p>
                                            <div className='row-flex margintop2'>
                                                <div className='row-flex-two'>
                                                    <p>Số phiếu kiểm định<br/>
                                                    <span className="small-text">(VehicleInspection Report No)</span><br/>
                                                    <input type='text'/><br/>
                                                    Có hiệu lức đến hết ngày<br/>
                                                    <span className="small-text">(valid until)</span> <input type='text' value="01/07/2021"/></p>
                                                </div>
                                                <div className='row-flex-three'>
                                                    <p>Hà Nội, ngày {moment().format("DD")} tháng {moment().format("MM")} năm {moment().format("YYYY")}<br/><span className="small-text">(Issued on: Day/Month/Year)</span><br/><h3>ĐƠN VỊ KIỂM ĐỊNH</h3><span className="small-text">(INSPECTION CENTER)</span></p>
                                                </div>
                                            </div>
                                            <img src="https://th.bing.com/th/id/OIP.6Jq8cQRKZB9oMEQLDsE9DAHaEK?pid=ImgDet&rs=1"/>
                                            <div className='spaceAround'>
                                                <p>Có lắp thiết bị giám sát hành trình <span className='small-text'>(Equipped with Tachograph)</span></p> <span className="right-side"><input type='checkbox' checked={selectedRowData.equipped_with_tachograph === "True"}/></span>
                                            </div>
                                            <div className='spaceAround'>
                                                <p>Không cấp tem kiểm định <span className='small-text'>(Inspection stamp was not issued)</span></p> <span className="right-side"><input type='checkbox' checked={selectedRowData.equipped_with_camera === "True"}/></span>
                                            </div>
                                            <div className='spaceAround'>
                                                <p><span className='small-text'>Ghi chú:</span> {selectedRowData.notes}</p>
                                                <i className='bx bxs-file-export' onClick={handlePrint} style={{ cursor: 'pointer', marginLeft: '0.5rem' }}></i>
                                            </div>
                                        </div>
                                    </div>
                                )}
                            </form>
                            </div>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
}

export default SearchContent;