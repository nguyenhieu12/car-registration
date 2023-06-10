import React, { useState } from 'react';
import { utils, read } from 'xlsx';
import './SearchContent.css';
import 'boxicons/css/boxicons.min.css';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import "primereact/resources/primereact.min.css"; 
import 'boxicons/css/boxicons.min.css';
import { FilterMatchMode } from 'primereact/api';
import { InputText } from 'primereact/inputtext';

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
                <i className="bx bx-edit-alt" onClick={() => alertMessage(rowData)} style={{ cursor: 'pointer' }}></i>
                <i className="bx bx-trash-alt" onClick={() => handleDeleteRow(rowData)} style={{ cursor: 'pointer', marginLeft: '0.5rem' }}></i>
            </div>
        );
    };

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
            </div>
        </div>
    );
}

export default SearchContent;