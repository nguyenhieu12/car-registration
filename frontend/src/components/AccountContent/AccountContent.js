import React, { useState, useEffect, useRef } from 'react';
import './AccountContent.css';
import moment from 'moment';
import {toast, ToastContainer} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

function AccountContent(props) {
    const [currentIndex, setCurrentIndex] = useState(0);
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
    const token = localStorage.getItem('token');

    const [fullName, setFullName] = useState('');
    const [gender, setGender] = useState('');
    const [dateOfBirth, setDateOfBirth] = useState('');
    const [phoneNumber, setPhoneNumber] = useState('');
    const [citizenId, setCitizenId] = useState('');
    const [email, setEmail] = useState('');
    const [description, setDescription] = useState('');
    const [role, setRole] = useState('');
    const [companyInfo, setCompanyInfo] = useState({
      inspectionStation: "",
      stationCode: "",
      stationManager: "",
      hotline: "",
    }); 
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState(''); 
    const fullNameInputRef = useRef(null);
    const dateOfBirthInputRef = useRef(null);
    const phoneNumberInputRef = useRef(null);
    const citizenIdInputRef = useRef(null);
    const emailInputRef = useRef(null);
    const descriptionInputRef = useRef(null);
    const usernameInputRef = useRef(null);
    const passwordInputRef = useRef(null);

    function checkFormatEmail(e) {
      const regex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      if(!regex.test(e)) {
        return false;
      }
      return true;
    }

    function checkFormatDob(dob) {
      const dateFormat = "DD/MM/YYYY";
      return moment(dob, dateFormat, true).isValid();
    }

    function checkValidDob(dob) {
      const [ngay, thang, nam] = dob.split("/").map(Number);
  
      if (isNaN(ngay) || isNaN(thang) || isNaN(nam)) {
        return false;
      }
      if (thang > 12 || thang < 1) {
        return false;
      }
      if (
        thang === 1 ||
        thang === 3 ||
        thang === 5 ||
        thang === 7 ||
        thang === 8 ||
        thang === 10 ||
        thang === 12
      ) {
        if (ngay > 31) return false;
      } else if (thang === 2) {
        if ((nam % 4 === 0 && nam % 100 !== 0) || nam % 400 === 0) {
          if (ngay > 29) return false;
        } else if (ngay > 28) return false;
      } else if (ngay > 30) return false;
  
      if (ngay < 1) return false;
  
      const currentYear = new Date().getFullYear();
      const currentMonth = new Date().getMonth() + 1;
      if (
        nam > currentYear ||
        (thang > currentMonth && nam >= currentYear) ||
        nam < 1900
      )
        return false;
  
      return true;
    }

    const formRef = useRef();

    const handleUpdate = (index) => {
        if (index === 0) {
            if (!inputValues.station_name) {
                if (!toast.isActive('stationName')) {
                    toast.error('Cần phải chọn trung tâm', {
                      toastId: 'stationName',
                      autoClose: 1500
                    });
                  }
            }
            if (!fullName) {
                if (!toast.isActive('fullName')) {
                  toast.error('Họ và tên không được để trống', {
                    toastId: 'fullName',
                    autoClose: 1500
                  });
                }
              }
              if (!phoneNumber) {
                if (!toast.isActive('phoneNumber')) {
                  toast.error('Số điện thoại không được để trống', {
                    toastId: 'phoneNumber',
                    autoClose: 1500
                  });
                }
              }
              if (!citizenId) {
                if (!toast.isActive('citizenId')) {
                  toast.error('Số CCCD không được để trống', {
                    toastId: 'citizenId',
                    autoClose: 1500
                  });
                }
              }
              if (!email) {
                if (!toast.isActive('email')) {
                  toast.error('Email không được để trống', {
                    toastId: 'email',
                    autoClose: 1500
                  });
                }
              } else if (!checkFormatEmail(email)) {
                if (!toast.isActive('checkEmail')) {
                  toast.error('Email không đúng định dạng', {
                    toastId: 'checkEmail',
                    autoClose: 1500
                  });
                }
              }
              if (!dateOfBirth) {
                if (!toast.isActive('dateOfbirth')) {
                  toast.error('Ngày sinh không được để trống', {
                    toastId: 'dateOfbirth',
                    autoClose: 1500
                  });
                }
              } else if (!checkFormatDob(dateOfBirth)) {
                if (!toast.isActive('checkFormat')) {
                  toast.error('Ngày sinh không đúng định dạng', {
                    toastId: 'checkFormat',
                    autoClose: 1500
                  });
                }
              } else if (!checkValidDob(dateOfBirth)) {
                if (!toast.isActive('checkValidDob')) {
                  toast.error('Ngày sinh không hợp lệ', {
                    toastId: 'checkValidDob',
                    autoClose: 1500
                  });
                }
              } 
              if (fullName && phoneNumber && citizenId && email && dateOfBirth && checkValidDob(dateOfBirth) && checkFormatDob(dateOfBirth) && checkFormatEmail(email)) {
                console.log(fullName + " " + gender + " " + dateOfBirth + " " + phoneNumber + " " + citizenId + " " + email + " " + description + " ")
                setCurrentIndex(currentIndex+1);
              }
        } else {
            if (!username) {
                if (!toast.isActive('username')) {
                  toast.error('Tài khoản không được để trống', {
                    toastId: 'username',
                    autoClose: 1500
                  });
                }
            }
            if (!password) {
                if (!toast.isActive('password')) {
                  toast.error('Mật khẩu không được để trống', {
                    toastId: 'password',
                    autoClose: 1500
                  });
                }
            }
            if (!role) {
                if (!toast.isActive('role')) {
                    toast.error('Cần phải chọn vị trí', {
                      toastId: 'role',
                      autoClose: 1500
                    });
                  }
            }
            if (username && password && role) {
                console.log(role + " " + username + " " + password + " ")
                createUser();
            }
        }
    };

    const createUser = async () => {
        const dob = moment(dateOfBirth, "DD/MM/YYYY").format("YYYY-MM-DD") + "T07:00:00+07:00";
        const lastSpaceIndex = fullName.lastIndexOf(" ");
        const firstName1 = fullName.substring(lastSpaceIndex + 1);
        const lastName1 = fullName.substring(0, lastSpaceIndex);
        const payload = {
          first_name: firstName1,
          last_name: lastName1,
          date_of_birth: dob,
          phone_number: phoneNumber,
          identity_no: citizenId,
          email: email,
          about: description,
          station_code: companyInfo.stationCode,
          role: role,
          username: username,
          password: password
        };
        fetch(`http://localhost:5000/api/v1/auth/register`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`
          },
          body: JSON.stringify(payload)
        })
            .then(response => response.json())
            .then(data => {
              if (!toast.isActive('updateInformation')) {
                toast.success('Cấp tài khoản thành công', {
                  toastId: 'updateInformation',
                  autoClose: 1500
                });
              }
            })
            .catch(error => {
              console.error(error);
              if (!toast.isActive('updateInformation-error')) {
                toast.error('Cấp tài khoản thất bại', {
                  toastId: 'updateInformation-error',
                  autoClose: 1500
                });
              }
            });
      };
     const dataRole = [
        {role_id: 0, role_name: "god"},
        {role_id: 1, role_name: "vrhead"},
        {role_id: 2, role_name: "vrstaff"},
        {role_id: 3, role_name: "admin"},
        {role_id: 4, role_name: "staff"},
     ]
  
    const handleKeyDown = (event, nextInputRef) => {
      if (event.key === "Enter") {
        event.preventDefault();
        nextInputRef.current.focus();
      }
    };

    const [data, setData] = useState([]);

    const getAllStation = async () => {
        fetch(`http://localhost:5000/api/v1/station`, {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`
          },
        })
            .then(response => response.json())
            .then(data => {
              setData(data.data.stations);
            })
            .catch(error => {
              console.error(error); 
            });
      };

    useEffect(() => {
        getAllStation();
    }, [])

    const [selectedRole, setSelectedRole] = useState('');
    const handleRoleChange = (event) => {
        const selectedRoleId = event.target.value;
        setSelectedRole(selectedRoleId);
        const selectedRoleData = dataRole.find((role) => role.role_id === parseInt(selectedRoleId));
        setRole(selectedRoleData ? selectedRoleData.role_name : '');
    }

    const [selectedStation, setSelectedStation] = useState('');
    const [inputValues, setInputValues] = useState({station_name: '', station_code: '', station_manager: '', station_hotline: '' });

    const handleStationChange = (event) => {
        const selectedStationId = event.target.value;
        setSelectedStation(selectedStationId);

        const selectedStationData = data.find((station) => station.station_id === parseInt(selectedStationId));

        setInputValues({
        station_name: selectedStationData ? selectedStationData.station_name : '',
        station_code: selectedStationData ? selectedStationData.station_code : '',
        station_manager: selectedStationData ? selectedStationData.station_manager : '',
        station_hotline: selectedStationData ? selectedStationData.station_hotline : ''
        });

        setCompanyInfo({
            inspectionStation: inputValues.station_name,
            stationCode: inputValues.station_code,
            stationManager: inputValues.station_manager,
            hotline: inputValues.station_hotline,
        });
    };


    return (
        <div className='account-content-container'>
            <div className='spaceAround'>
                <section className="step-wizard">
                    <ul className="step-wizard-list">
                        <li className={`step-wizard-item  ${currentIndex === 0 ? 'current-item' : ''}`}>
                            <span className="progress-count">1</span>
                            <span className="progress-label">Thông tin</span>
                        </li>
                        <li className={`step-wizard-item  ${currentIndex === 1 ? 'current-item' : ''}`}>
                            <span className="progress-count">2</span>
                            <span className="progress-label">Tài khoản</span>
                        </li>
                    </ul>
                </section>
                <div>
                    <label htmlFor='button-u' className='app-content-headerButton-u'>{currentIndex === 1 ? "Cấp tài khoản" : "Tiếp tục"}</label>
                    <button id='button-u' className='button-update' type="button" onClick={() => handleUpdate(currentIndex)} style={{ 'display': 'none' }} />
                </div>
            </div>
            <div className='account-content-main personinfo-container'>
            <ToastContainer/>    
            {currentIndex === 0 ? (
                <form className='account-content-flex'>
                    <div className='account-content-flex-two'>
                    <h1 className='personinfo-headerText'>Thông tin trung tâm</h1>
                          <div className="form-row">
                            <div className="input-container distance">
                              <label htmlFor="inspectionStation">Trung tâm đăng kiểm</label>
                              <select className="select-container" value={selectedStation} onChange={handleStationChange}>
                                    <option value="">Chọn</option>
                                    {data.map((station) => (
                                    <option key={station.station_id} value={station.station_id}>
                                        {station.station_name}
                                    </option>
                                    ))}
                                </select>
                            </div>
                            <div className="input-container">
                              <label htmlFor="stationCode2">Mã số trung tâm</label>
                              <input
                                type="text"
                                id="stationCode2"
                                value={inputValues.station_code}
                                title='Không thể sửa đổi'
                                className='input-disabled'
                                disabled
                              />
                            </div>
                          </div>
                          <div className="form-row">
                            <div className="input-container distance">
                              <label htmlFor="stationManager2">Quản lý trung tâm</label>
                              <input
                                type="text"
                                id="stationManager2"
                                value={inputValues.station_manager}
                                title='Không thể sửa đổi'
                                className='input-disabled'
                                disabled
                              />
                            </div>
                            <div className="input-container">
                              <label htmlFor="hotline2">Hotline</label>
                              <input
                                type="text"
                                id="hotline2"
                                value={inputValues.station_hotline}
                                title='Không thể sửa đổi'
                                className='input-disabled'
                                disabled
                              />
                            </div>
                          </div>

                          <p className='note'>Lưu ý: Cần chọn trung tâm, để tự động điền mã trung tâm, quản lý và số hotline từ trong cơ sở dữ liệu</p>  
                    </div>
                    <form className='account-content-flex-three'>
                    <h1 className='personinfo-headerText'>Thông tin cá nhân</h1>
                          <div className="form-row">
                            <div className="input-container distance">
                              <label htmlFor="fullName2">Họ và tên</label>
                              <input
                                type="text"
                                id="fullName2"
                                value={fullName}
                                onChange={(e) => setFullName(e.target.value
                                  .split(" ")
                                  .map(
                                    (word) =>
                                      word.charAt(0).toUpperCase() + word.slice(1)
                                  )
                                  .join(" "))}
                                onKeyDown={(e) => handleKeyDown(e, dateOfBirthInputRef)}
                                ref={fullNameInputRef}
                              />
                            </div>
                            <div className='input-container-flex'>
                              <div className="input-container gender">
                                <label className='gender-title' htmlFor="gender23">Giới tính</label>
                                <div className='checkbox-gender'>
                                  <label>
                                      <input
                                          type="checkbox"
                                          id="gender2"
                                          value={gender}
                                          onChange={(e) => setGender(e.target.value)}
                                          className='input-disabled'
                                      />
                                      <p style={{"color": "#000"}}>Nam</p>
                                  </label>
                                  <label>
                                      <input
                                          type="checkbox"
                                          id="gender3"
                                          value={gender}
                                          onChange={(e) => setGender(e.target.value)}
                                          className='input-disabled'
                                      />
                                      <p style={{"color": "#000"}}>Nữ</p>
                                  </label>
                                </div>
                              </div>
                              <div className="input-container">
                                <label htmlFor="dateOfBirth2">Ngày sinh</label>
                                <input
                                  type="text"
                                  id="dateOfBirth2"
                                  value={dateOfBirth}
                                  onChange={(e) => setDateOfBirth(e.target.value)}
                                  onKeyDown={(e) => handleKeyDown(e, phoneNumberInputRef)}
                                  ref={dateOfBirthInputRef}
                                />
                              </div>
                            </div>
                          </div>
                          <div className="form-row">
                            <div className="input-container distance">
                              <label htmlFor="phoneNumber2">Số điện thoại</label>
                              <input
                                type="text"
                                id="phoneNumber2"
                                value={phoneNumber}
                                onChange={(e) => setPhoneNumber(e.target.value)}
                                onKeyDown={(e) => handleKeyDown(e, citizenIdInputRef)}
                                ref={phoneNumberInputRef}
                              />
                            </div>
                            <div className="input-container">
                              <label htmlFor="citizenId2">Số căn cước công dân</label>
                              <input
                                type="text"
                                id="citizenId2"
                                value={citizenId}
                                onChange={(e) => setCitizenId(e.target.value)}
                                onKeyDown={(e) => handleKeyDown(e, emailInputRef)}
                                ref={citizenIdInputRef}
                              />
                            </div>
                          </div>
                          <div className='form-row'>
                          <div className="input-container">
                              <label htmlFor="email2">Email</label>
                              <input
                                type="text"
                                id="email2"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                onKeyDown={(e) => handleKeyDown(e, descriptionInputRef)}
                                ref={emailInputRef}
                              />
                            </div>
                          </div>
                          <div className="form-row">
                            <div className="input-container">
                              <label htmlFor="description2">Mô tả</label>
                              <textarea
                                id="description2"
                                value={description}
                                onChange={(e) => setDescription(e.target.value)}
                                ref={descriptionInputRef}
                              ></textarea>
                            </div>
                          </div>
                    </form>                    
                </form>
                ) : (
                <div>
                    <form>
                    <h1 className='personinfo-headerText'>Nhập tài khoản</h1>
                        <div className="form-row">
                            <div className="input-container distance">
                              <label htmlFor="username2">Tài khoản</label>
                              <input
                                type="text"
                                id="username2"
                                value={username}
                                onChange={(e) => setUsername(e.target.value)}
                                onKeyDown={(e) => handleKeyDown(e, passwordInputRef)}
                                ref={usernameInputRef}
                              />
                            </div>
                            <div className='input-container'>
                                <label>Vị trí</label>
                                <select  className="select-container" value={selectedRole} onChange={handleRoleChange}>
                                    <option value="">Chọn</option>
                                    {dataRole.map((role) => (
                                    <option key={role.role_id} value={role.role_id}>
                                        {role.role_name}
                                    </option>
                                    ))}
                                </select>
                            </div>
                        </div>
                        <div className="input-container">
                              <label htmlFor="password2">Mật khẩu</label>
                              <input
                                type="password"
                                id="password2"
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}
                                onKeyDown={(e) => handleKeyDown(e, null)}
                                ref={passwordInputRef}
                              />
                        </div>

                        <p className='note'>Lưu ý: Hãy nhớ thật kỹ tài khoản mật khẩu</p>
                    </form>
                </div>
                )}
            </div>
        </div>
    );
}

export default AccountContent;