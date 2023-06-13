import React, { useState, useRef } from 'react';
import { utils, read } from 'xlsx';
import './RegistrationCar.css';
import 'boxicons/css/boxicons.min.css';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import "primereact/resources/primereact.min.css"; 
import 'boxicons/css/boxicons.min.css';
import { FilterMatchMode } from 'primereact/api';
import { InputText } from 'primereact/inputtext';
import { useReactToPrint } from 'react-to-print';
import moment from 'moment';
import {toast, ToastContainer} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

function RegistrationCar(props) {
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
    const token = localStorage.getItem('token');
    const [excelData, setExcelData] = useState([]);
    const file_type = ["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.ms-excel"];
    const [autoNumber, setAutoNumber] = useState(1);
    const handleChange = (e) => {
        const selected_file = e.target.files[0];
        if (selected_file) {
            if (selected_file && file_type.includes(selected_file.type)) {
                let reader = new FileReader();
                reader.onload = (e) => {
                    const workbook = read(e.target.result);
                    const sheet = workbook.SheetNames;
                    if (sheet.length) {
                        const data = utils.sheet_to_json(workbook.Sheets[sheet[0]]);
                        const newData = data.map((row, index) => ({ ...row, index: index + 1 }));
                        setExcelData(newData);
                        setAutoNumber(data.length + 1); // Cập nhật số thứ tự tự động
                    }
                };
                reader.readAsArrayBuffer(selected_file);
            } else {
                setExcelData([]);
                setAutoNumber(1); // Reset số thứ tự
            }
        }
    };
    
    const[type, setType] = useState("");

    const [filters, setFilters] = useState({
        global: { value: null, matchMode: FilterMatchMode.CONTAINS },
    });

    const handleDeleteRow = (rowData) => {
        const updatedData = excelData.filter((row) => row.index !== rowData.index);
        const newData = updatedData.map((row, index) => ({ ...row, index: index + 1 }));
        setExcelData(newData);
        setAutoNumber(updatedData.length + 1); // Cập nhật số thứ tự tự động
    };

    const updateInspection = async () => {
        const currentDate = moment().format("YYYY-MM-DD") + "T00:00:00Z";
        const expiryDate = moment(currentDate).add(2, 'years').format("YYYY-MM-DD") + "T00:00:00Z";
        const payload = {
            expiry_date: expiryDate,
            inspection_date: currentDate,
            registration_id: selectedRowData.registration_id,
            station_code: "2901S",
            inspection_id: Math.floor(Math.random() * (10000 - 4000 + 1)) + 4000,
        };
        fetch(`http://localhost:5000/api/v1/insp`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`
          },
          body: JSON.stringify(payload)
        })
            .then(response => response.json())
            .then(data => {
            //   console.log(data);
              if (!toast.isActive('success')) {
                toast.success('Đăng kiểm thành công', {
                  toastId: 'success',
                  autoClose: 1500,
                });
              }
            })
            .catch(error => {
            //   console.error(error);
              if (!toast.isActive('updatePass-error')) {
                  toast.error('Đăng kiểm thất bại', {
                    toastId: 'updatePass-error',
                    autoClose: 1500
                  });
                }
            });
      };

    const emptyMessage = "Cần nhập dữ liệu thông tin đăng ký xe để xử lý";

    const actionTemplate = (rowData) => {
        const handleIconClick = () => {
              triggerModal(rowData);
          };
        return (
            <div>
                <i className="bx bx-show" onClick={handleIconClick} style={{ cursor: 'pointer' }}></i>
                {/* <i className='bx bx-search' style={{ cursor: 'pointer', marginLeft: '0.5rem' }}></i> */}
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

    const handlePrintFile = () => {
        if (window.confirm('Bạn có muốn in hoặc tải giấy đăng kiểm?')) {
            handlePrint();
            updateInspection();
        }
        return;
    }
    const handlePrint = useReactToPrint({
        content: () => componentRef.current,
    });

    const [selectedRowData, setSelectedRowData] = useState(null);

    return (
        <div className='searchContent-container'>
            <div className="app-container">
                <div className="app-content">
                    <div className="app-content-header">
                        <h1 className="app-content-headerText">Thông tin đăng ký xe</h1>
                        <label htmlFor='import-excel' className='app-content-headerButton'>Nhập dữ liệu</label>
                        <input type='file' id='import-excel' onChange={handleChange} style={{ 'display': 'none' }} />
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
                    <DataTable value={excelData} className="my-table" filters={filters} emptyMessage={emptyMessage} paginator rows={10} tableStyle={{ minWidth: '50rem' }}>
                        <Column field="index" header="Thứ tự" sortable body={(rowData) => rowData.index} />
                        <Column field="full_name" header="Họ và tên" sortable />
                        <Column field="registration_id" header="Biển số xe" sortable />
                        <Column field="registration_date" header="Ngày đăng ký" sortable body={(rowData) => moment(rowData.registration_date).format("DD/MM/YYYY")} />
                        <Column field='place_of_registration' header='Nơi đăng ký' sortable/>
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
                                                <p>Số quản lý: {selectedRowData.manufactured_year * 3 + "UV" + selectedRowData.manufactured_year * 2}<br/>
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
                                                <p>Số seri: <span className="small-text">(No.)</span> {selectedRowData.manufactured_year * 2 + 1999} </p>
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
                                                    {selectedRowData.manufactured_year * 2 + "VRN" + selectedRowData.manufactured_year * 4}<br/>
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
                                                <i className='bx bxs-file-export' onClick={handlePrintFile} style={{ cursor: 'pointer', marginLeft: '0.5rem' }}></i>
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

export default RegistrationCar;