import React, { useState, useRef } from 'react';
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

function SearchContent(props) {
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
    

    const [filters, setFilters] = useState({
        global: { value: null, matchMode: FilterMatchMode.CONTAINS },
    });

    const handleDeleteRow = (rowData) => {
        const updatedData = excelData.filter((row) => row.index !== rowData.index);
        const newData = updatedData.map((row, index) => ({ ...row, index: index + 1 }));
        setExcelData(newData);
        setAutoNumber(updatedData.length + 1); // Cập nhật số thứ tự tự động
    };

    const emptyMessage = "Cần nhập dữ liệu thông tin đăng ký xe để xử lý";

    const alertMessage = (rowData) => {
        alert(`Bạn đã nhấp vào biểu tượng với dữ liệu: ${JSON.stringify(rowData)}`);
    };

    const actionTemplate = (rowData) => {
        return (
            <div>
                <i className="bx bx-edit-alt" onClick={() => triggerModal(rowData)} style={{ cursor: 'pointer' }}></i>
                <i className="bx bx-trash-alt" onClick={() => handleDeleteRow(rowData)} style={{ cursor: 'pointer', marginLeft: '0.5rem' }}></i>
            </div>
        );
    };

    const [modal, setModal] = useState(false);
    const triggerModal = (rowData) => {
        setModal(!modal);
    };

    const componentRef = useRef();
    const handlePrint = useReactToPrint({
        content: () => componentRef.current,
    });

    return (
        <div className='searchContent-container'>
            <div className="app-container">
                <div className="app-content">
                    <div className="app-content-header">
                        <h1 className="app-content-headerText">Tra cứu</h1>
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
                        <Column field="registration_date" header="Ngày đăng ký" sortable />
                        <Column field='place_of_registration' header='Nơi đăng ký' sortable/>
                        <Column body={actionTemplate} header="" style={{ textAlign: 'center', width: '6rem' }} />
                    </DataTable>
                </div>
                <div className="container">
                    {modal && (
                        <div ref={componentRef} className="popup">
                            <div onClick={triggerModal} className="overlay"></div>
                            <div className="modal-content" id="inspection-report">
                            <form className="form">
                                <div className='form-row-popup'>
                                    <div className='form-row-popup-item outline'>
                                        <h3>1. PHƯƠNG TIỆN <span className="big-text">(VEHICLE)</span></h3>
                                        <div className='row-flex'>
                                        <div className='row-flex-item'>
                                            <p>Biển đăng ký: 51F-516.04<br/>
                                            <span className="small-text">(Registration Number)</span></p>
                                        </div>
                                        <div className='row-flex-item'>
                                            <p>Số quản lý: 5005V-122752<br/>
                                            <span className="small-text">(Vehicle Inspection No.)</span></p>
                                        </div>
                                        </div>
                                        <p>Loại phương tiện: <span className="small-text">(Type)</span> ô tô con</p>
                                        <p>Nhãn hiệu: <span className="small-text">(Mark)</span> KIA</p>
                                        <p>Số loại: <span className="small-text">(Model code)</span> MORNING TA 12G E2 AT-1</p>
                                        <p>Số khung: <span className="small-text">(Chassis Number)</span> RNYTC51A4FC066108</p>
                                        <div className='row-flex'>
                                        <div className='row-flex-item'>
                                            <p>Năm, Nước sản xuất: 2015, Việt Nam<br/>
                                            <span className="small-text">(Manufactured Year and Country)</span></p>
                                        </div>
                                        <div className='row-flex-item'>
                                            <p>Năm hết niên hạn SD:<br/>
                                            <span className="small-text">(Lifetime limit to)</span></p>
                                        </div>
                                        </div>
                                        <div className='row-flex'>
                                        <p>Kinh doanh vận tải <span className="small-text">(Commercial Use)</span></p>
                                        <input type='checkbox' checked/>
                                        <p> Cải tạo <span className="small-text">(Modification)</span></p>
                                        <input type='checkbox'/>
                                        </div>
                                        <h3 className='margintop'>2. THÔNG SỐ KỸ THUẬT <span className="big-text">(SPECIFICATIONS)</span></h3>
                                        <div className='row-flex'>
                                        <div className='row-flex-item'>
                                            <p>Công thức bánh xe: 4x2<br/>
                                            <span className="small-text">(Wheel Formula)</span></p>
                                        </div>
                                        <div className='row-flex-item'>
                                            <div className='spaceAround'>
                                                <p>Vết bánh xe:</p> <p className="right-side">1475/1459 (mm)</p>
                                            </div>
                                            <p><span className="small-text">(Wheel Tread)</span></p>
                                        </div>
                                        </div>
                                        <div className='spaceAround'>
                                            <p>Kích thước bao: <span className="small-text">(Overall Dismension)</span></p> <p className="right-side">3817 x 1682 x 1487 (mm)</p>
                                        </div>
                                        <div className='spaceAround'>
                                            <p>KT khoang hành lý lớn nhất</p> <p className="right-side">(mm)</p>
                                        </div>
                                        <p><span className="small-text">(Langest luggage container dimension)</span></p>
                                        <div className='spaceAround'>
                                            <p>Khối lượng bản thân: <span className="small-text">(Kerb mass)</span></p> <p className="right-side">991 (mm)</p>
                                        </div>
                                        <div className='spaceAround'>
                                            <p>Khối lượng hàng CC theo TK/CP TGGT:</p> <p className="right-side">(kg)</p>
                                        </div>
                                        <span className="small-text">(Design/Authorized total mass)</span>
                                        <div className='spaceAround'>
                                            <p>Khối lượng kéo theo TK/CP TGGT:</p> <p className="right-side">1366/1366 (kg)</p>
                                        </div>
                                        <span className="small-text">(Design/Authorized towed mass)</span>
                                        <p>Số người cho phép chở: 5 chỗ ngồi, 0 chỗ đứng, 0 chỗ nằm<br/>
                                        <span className="small-text">(Permissible No. of Pers Carried: seat, stood place, laying place)</span></p>
                                        <p>Loại nhiên liệu: <span className="small-text">(Type of Fuel Used)</span> Xăng</p>
                                        <div className='spaceAround'>
                                            <p>Thể tích làm việc của động cơ: <span className="small-text">(Engine Displacement)</span></p> <p className="right-side">1199 (cm3)</p>
                                        </div>
                                        <div className='spaceAround'>
                                            <p>Công suất lớn nhất/Tốc độ quay: <span className="small-text">(Max. output/rpm)</span></p> <p className="right-side">66(kW)/6000vph</p>
                                        </div>
                                        <p>Số seri: <span className="small-text">(No.)</span></p>
                                    </div>
                                    <div className='form-row-popup-item outline'>
                                        <p>Số lượng lốp, cỡ lốp/trục <span className="small-text">(Number of tires, Tires size/axle)</span></p>
                                        <p>1: 2; 255/55R20</p>
                                        <p>2: 2; 255/55R20</p>
                                        <div className='row-flex margintop2'>
                                            <div className='row-flex-two'>
                                                <p>Số phiếu kiểm định<br/>
                                                <span className="small-text">(VehicleInspection Report No)</span><br/>
                                                5005V-50103/20<br/>
                                                Có hiệu lức đến hết ngày<br/>
                                                <span className="small-text">(valid until)</span> <input type='text' value="01/07/2021"/></p>
                                            </div>
                                            <div className='row-flex-three'>
                                                <p>TP.HCM, ngày 2 tháng 1 năm 2020<br/><span className="small-text">(Issued on: Day/Month/Year)</span><br/><h3>ĐƠN VỊ KIỂM ĐỊNH</h3><span className="small-text">(INSPECTION CENTER)</span></p>
                                            </div>
                                        </div>
                                        <img src="https://th.bing.com/th/id/OIP.6Jq8cQRKZB9oMEQLDsE9DAHaEK?pid=ImgDet&rs=1"/>
                                        <div className='spaceAround'>
                                            <p>Có lắp thiết bị giám sát hành trình <span className='small-text'>(Equipped with Tachograph)</span></p> <span className="right-side"><input type='checkbox' check/></span>
                                        </div>
                                        <div className='spaceAround'>
                                            <p>Không cấp tem kiểm định <span className='small-text'>(Inspection stamp was not issued)</span></p> <span className="right-side"><input type='checkbox'/></span>
                                        </div>
                                        <div className='spaceAround'>
                                           <p><span className='small-text'>Ghi chú:</span> Biển đăng ký nền trắng</p>
                                           <i className='bx bxs-file-export' onClick={handlePrint} style={{ cursor: 'pointer', marginLeft: '0.5rem' }}></i>
                                        </div>
                                    </div>
                                </div>
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