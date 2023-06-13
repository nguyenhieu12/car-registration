import React, { useState, useRef, useEffect } from 'react';
import { utils, read } from 'xlsx';
// import './NewsContent.css';
import 'boxicons/css/boxicons.min.css';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import "primereact/resources/primereact.min.css";
import 'boxicons/css/boxicons.min.css';
import { FilterMatchMode } from 'primereact/api';
import { InputText } from 'primereact/inputtext';
import { useReactToPrint } from 'react-to-print';
import moment from 'moment';
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';


function NewsContent(props) {
  const currentUser = JSON.parse(localStorage.getItem('currentUser'));
  const token = localStorage.getItem('token');
  const [filters, setFilters] = useState({
    global: { value: null, matchMode: FilterMatchMode.CONTAINS },
  });
  const [autoNumber, setAutoNumber] = useState(1);
  const [registrationID, setRegistrationID] = useState({});

  const getDataVehicle = async (registration_id) => {
    fetch(`http://localhost:5000/api/v1/vehicle/details/${registration_id}`, {
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
    fetch(`http://localhost:5000/api/v1/auth/all?page=0&size=1000`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      },
    })
      .then(response => response.json())
      .then(data => {
        console.log(data.data.users);
        const newData = data.data.users.map((row, index) => ({ ...row, index: index + 1 }));
        setData(newData);
        setAutoNumber(data.length + 1)
      })
      .catch(error => {
        console.error(error);
      });
  };

  useEffect(() => {
    // getDataVehicle(selectedRowData.registration_id);
    getData();
  }, [])

  const handleDeleteRow = (rowData) => {

    const confirmed = window.confirm('Are you sure you want to delete this row?');
    if (confirmed) {
      console.log(rowData);
      fetch(`http://localhost:5000/api/v1/auth/${rowData.user_id}`, {
        method: 'DELETE',
        headers: {
          // 'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`

        },
        // body: JSON.stringify(rowData),
      })
        .then((response) => {
          if (response.ok) {
            // Row deleted successfully
            console.log('Row deleted');

            toast.success('Xóa thành công!', {
              position: toast.POSITION.TOP_RIGHT,
              autoClose: 1500
            });
            const updatedData = data.filter((row) => row.index !== rowData.index);
            const newData = updatedData.map((row, index) => ({ ...row, index: index + 1 }));
            setData(newData);
            setAutoNumber(updatedData.length + 1); 
          } else {
            // Handle error condition
            console.error('Error deleting row:', response.status);
            toast.error('Xóa lỗi! Hãy thử lại', {
              toastId: 'wrongInfo',
              autoClose: 1500
            });
          }
        })
        .catch((error) => {
          console.error('Error deleting row:', error);
        });
    }
  };

  const handleUpdateSubmit = (rowData) => {

    const confirmed = window.confirm('Are you sure you want to delete this row?');
    if (confirmed) {
      console.log(rowData);
      fetch(`http://localhost:5000/api/v1/auth/${rowData.user_id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`

        },
        // body: JSON.stringify(rowData),
      })
        .then((response) => {
          if (response.ok) {
            // Row deleted successfully
            console.log('Row deleted');

            toast.success('Xóa thành công!', {
              position: toast.POSITION.TOP_RIGHT,
              autoClose: 1500
            });
          } else {
            // Handle error condition
            console.error('Error deleting row:', response.status);
            toast.error('Xóa lỗi! Hãy thử lại', {
              toastId: 'wrongInfo',
              autoClose: 1500
            });
          }
        })
        .catch((error) => {
          console.error('Error deleting row:', error);
        });
    }



  };

  const handleIconClick = (rowData) => {
    if (moment(rowData.expiry_date).isBefore(moment())) {
      triggerModal(rowData);
    }
    // const data = getDataVehicle(selectedRowData.registration_id);
    // setVehicleData(data);
    console.log("log: ", data);

  };


  const actionTemplate = (rowData) => {

    return (
      <div>
        <i className="bx bx-edit-alt" onClick={handleIconClick(rowData)} style={{ cursor: 'pointer' }}></i>
        <i className="bx bx-trash-alt" onClick={() => handleDeleteRow(rowData)} style={{ cursor: 'pointer', marginLeft: '0.5rem' }}></i>
      </div>
    );
  };

  const [modal, setModal] = useState(false);
  const triggerModal = (rowData) => {
    setSelectedRowData(rowData);
    console.log(rowData);
    setModal(!modal);
  };

  const componentRef = useRef();
  const handlePrint = useReactToPrint({
    content: () => componentRef.current,
  });

  const [selectedRowData, setSelectedRowData] = useState(null);
  const [vehicleData, setVehicleData] = useState(null);
  // const [selectedDetailData, setSelectedRowData] = useState(null);

  return (
    <div className='searchContent-container'>
      <div className="app-container">
        <div className="app-content">
          <div className="app-content-header">
            <h1 className="app-content-headerText">Quản lý người dùng</h1>
          </div>


          <div className="app-content-actions">
            <div className="search-box">
              <i className='bx bx-search'></i>
              <InputText
                onInput={(e) =>
                  setFilters({
                    global: { value: e.target.value, matchMode: FilterMatchMode.CONTAINS }
                  })
                }
              />
            </div>
          </div>

          <DataTable value={data} className="my-table" filters={filters} paginator rows={10} tableStyle={{ minWidth: '50rem' }}>
            <Column field="id" header="Số thứ tự" sortable body={(rowData) => rowData.index} />
            <Column field="user_id" header="Mã người dùng" sortable />
            <Column field="first_name" header="Tên" sortable />
            <Column field="email" header="Email" sortable />
            <Column field="user_name" header="Tài khoản" sortable />
            <Column field="about" header="Mô tả" sortable />
            <Column field="phone_number" header="Số điện thoại" sortable />
            <Column field="station_code" header="Mã Trung tâm" sortable />
            <Column field="identity_no" header="Số định danh" sortable />
            <Column field="gender" header="Giới tính" sortable />
            <Column field="date_of_birth" header="Ngày sinh" sortable body={(rowData) => moment(rowData.inspection_date).format("DD/MM/YYYY")} />
            <Column body={actionTemplate} header="" style={{ textAlign: 'center', width: '6rem' }} />
          </DataTable>


          <ToastContainer />

        </div>


      </div>
    </div>
  );
}

export default NewsContent;
