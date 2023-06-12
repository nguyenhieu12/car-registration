import React, {useState, useEffect, useRef} from 'react';
import './ProfileContent.css';
import 'boxicons/css/boxicons.min.css';
import ChangePassword from '../ChangePassword/ChangePassword';
import moment from 'moment';
import {toast, ToastContainer} from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

function ProfileContent({ isLoggedIn }) {
    const [currentIndex, setCurrentIndex] = useState(0);

    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
    const token = localStorage.getItem('token');

    const [fullName, setFullName] = useState('');
    const [tempFullName, setTempFullName] = useState('');
    const [gender, setGender] = useState('');
    const [dateOfBirth, setDateOfBirth] = useState('');
    const [tempDateOfBirth, setTempDateOfBirth] = useState('');
    const [phoneNumber, setPhoneNumber] = useState('');
    const [tempPhoneNumber, setTempPhoneNumber] = useState('');
    const [citizenId, setCitizenId] = useState('');
    const [tempCitizenId, setTempCitizenId] = useState('');
    const [email, setEmail] = useState('');
    const [tempEmail, setTempEmail] = useState('');
    const [description, setDescription] = useState('');
    const [tempDescription, setTempDescription] = useState('');
    const [companyInfo, setCompanyInfo] = useState({
      inspectionStation: "TTDK XCG 1101S - Hà Nội",
      stationCode: "1101S",
      stationManager: "Đinh Ngọc Hiến",
      hotline: "02063758742",
    });  
    const fullNameInputRef = useRef(null);
    const dateOfBirthInputRef = useRef(null);
    const phoneNumberInputRef = useRef(null);
    const citizenIdInputRef = useRef(null);
    const emailInputRef = useRef(null);
    const descriptionInputRef = useRef(null);

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

    const getUser = async () => {
      fetch(`http://localhost:5000/api/v1/auth/${currentUser.user_id}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`
        },
      })
          .then(response => response.json())
          .then(data => {
            setFullName(data.data.last_name + ' ' + data.data.first_name);
            setGender(data.data.gender);
            setDateOfBirth(moment(data.data.date_of_birth).format("DD/MM/YYYY"));
            setPhoneNumber(data.data.phone_number);
            setCitizenId(data.data.identity_no);
            setEmail(data.data.email);
            setDescription(data.data.about === "none" ? "" : data.data.about);
            setTempFullName(data.data.last_name + ' ' + data.data.first_name);
            setTempDateOfBirth(moment(data.data.date_of_birth).format("DD/MM/YYYY"));
            setTempPhoneNumber(data.data.phone_number);
            setTempCitizenId(data.data.identity_no);
            setTempEmail(data.data.email);
            setTempDescription(data.data.about === "none" ? "" : data.data.about);
          })
          .catch(error => {
            console.error(error);
          });
    };

    const formRef = useRef();

    const updateUser = async (id) => {
      const dob = moment(dateOfBirth, "DD/MM/YYYY").format("YYYY-MM-DD") + "T07:00:00+07:00";
      const lastSpaceIndex = fullName.lastIndexOf(" ");
      const firstName1 = fullName.substring(lastSpaceIndex + 1);
      const lastName1 = fullName.substring(0, lastSpaceIndex);

      console.log("First Name:", firstName1);
      console.log("Last Name:", lastName1);
      const payload = {
        first_name: firstName1,
        last_name: lastName1,
        date_of_birth: dob,
        phone_number: phoneNumber,
        identity_no: citizenId,
        email: email,
        about: description
      };
      fetch(`http://localhost:5000/api/v1/auth/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${token}`
        },
        body: JSON.stringify(payload)
      })
          .then(response => response.json())
          .then(data => {
            if (!toast.isActive('updateInformation')) {
              toast.success('Cập nhật thông tin thành công', {
                toastId: 'updateInformation',
                autoClose: 1500
              });
            }
          })
          .catch(error => {
            console.error(error);
            if (!toast.isActive('updateInformation-error')) {
              toast.error('Cập nhật thông tin thất bại', {
                toastId: 'updateInformation-error',
                autoClose: 1500
              });
            }
          });
    };

    const handleUpdate = () => {
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
        updateUser(currentUser.user_id);
        setTempDateOfBirth(dateOfBirth);
        setTempEmail(email);
        setTempFullName(fullName);
        setTempPhoneNumber(phoneNumber);
        setTempDescription(description);
        setTempCitizenId(citizenId);
      }
    };

    useEffect(() => {
      getUser();
    }, []);
  
    const handleCancel = () => {
      setFullName(tempFullName);
      setDateOfBirth(tempDateOfBirth);
      setPhoneNumber(tempPhoneNumber);
      setCitizenId(tempCitizenId);
      setEmail(tempEmail);
      setDescription(tempDescription);
    };
  
    const handleKeyDown = (event, nextInputRef) => {
      if (event.key === "Enter") {
        event.preventDefault();
        nextInputRef.current.focus();
      }
    };

    return (
        <div className="profile-container">
            <div className="profile-sidebar">
                <div className="profile-user">
                    <div className="profile-userpic">
                        <img src="https://scontent.fhan14-4.fna.fbcdn.net/v/t1.6435-9/182741929_107870648128506_6644574165595211881_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=5kAhAr4PEkoAX-zfreP&_nc_ht=scontent.fhan14-4.fna&oh=00_AfCJqeKHCh0PvtaZ9Y9AiY_0vUc6X8QkOtlc9loxucFV0w&oe=649DFFEE" width="100" height="100" alt="" />
                        <div className="round">
                        <input type="file" />
                        <i className='bx bx-camera'style={{ color: '#fff' }} ></i>
                        </div>
                    </div>
                    <div className="profile-usertitle">
                        <div className="profile-usertitle-name">
                            {tempFullName}
                        </div>
                        <div className="profile-usertitle-role">
                            {currentUser.role}
                        </div>
                    </div>
                </div>

                <div className='profile-userinfo'>
                <div className='profile-userinfo-item'>
                        <div>
                            <i className='bx bx-calendar-alt' ></i> Ngày sinh:
                        </div>
                        <div>
                            {tempDateOfBirth}
                        </div>
                    </div>
                    
                    <div className='profile-userinfo-item'>
                        <div>
                            <i className='bx bx-user'></i> Giới tính:
                        </div>
                        <div>
                            {gender}
                        </div>
                    </div>
                    
                    <div className='profile-userinfo-item'>
                        <div>
                            <i className='bx bx-phone' ></i> Số điện thoại:
                        </div>
                        <div>
                            {tempPhoneNumber}
                        </div>
                    </div>
                    
                    <div className='profile-userinfo-item'>
                        <div>
                            <i className='bx bx-envelope' ></i> Email:
                        </div>
                        <div>
                            {tempEmail}
                        </div>
                    </div>
                </div>
                
                <div className="profile-usermenu">
                    <ul className="profile-usermenu-nav">
                        <li className={currentIndex === 0 ? "active" : ""}>
                            <a href="#" onClick={() => setCurrentIndex(0)}>
                            Cập nhật thông tin </a>
                        </li>
                        <li className={currentIndex === 1 ? "active" : ""}>
                            <a href="#" onClick={() => setCurrentIndex(1)}>
                            Thay đổi mật khẩu </a>
                        </li>
                    </ul>
                </div>
                        
                </div>
                <div className="profile-content">
                    {currentIndex === 0 ? (
                        <div className="personinfo-container">
                        <ToastContainer/>
                        <form ref={formRef}>
                          <h1 className='personinfo-headerText'>Thông tin cá nhân</h1>
                          <div className="form-row">
                            <div className="input-container distance">
                              <label htmlFor="fullName">Họ và tên</label>
                              <input
                                type="text"
                                id="fullName"
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
                                <label className='gender-title' htmlFor="gender">Giới tính</label>
                                <div className='checkbox-gender'>
                                  <label>
                                      <input
                                          type="checkbox"
                                          id="gender"
                                          value={gender}
                                          onChange={() => {
                                          }}
                                          title='Không thể sửa đổi'
                                          className='input-disabled'
                                          disabled
                                          checked={currentUser.gender === "Nam"}
                                      />
                                      <p style={{"color": "#000"}}>Nam</p>
                                  </label>
                                  <label>
                                      <input
                                          type="checkbox"
                                          id="gender"
                                          value={gender}
                                          onChange={() => {
                                          }}
                                          title='Không thể sửa đổi'
                                          className='input-disabled'
                                          disabled
                                          checked={currentUser.gender === "Nữ"}
                                      />
                                      <p style={{"color": "#000"}}>Nữ</p>
                                  </label>
                                </div>
                              </div>
                              <div className="input-container">
                                <label htmlFor="dateOfBirth">Ngày sinh</label>
                                <input
                                  type="text"
                                  id="dateOfBirth"
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
                              <label htmlFor="phoneNumber">Số điện thoại</label>
                              <input
                                type="text"
                                id="phoneNumber"
                                value={phoneNumber}
                                onChange={(e) => setPhoneNumber(e.target.value)}
                                onKeyDown={(e) => handleKeyDown(e, citizenIdInputRef)}
                                ref={phoneNumberInputRef}
                              />
                            </div>
                            <div className="input-container">
                              <label htmlFor="citizenId">Số căn cước công dân</label>
                              <input
                                type="text"
                                id="citizenId"
                                value={citizenId}
                                onChange={(e) => setCitizenId(e.target.value)}
                                onKeyDown={(e) => handleKeyDown(e, emailInputRef)}
                                ref={citizenIdInputRef}
                              />
                            </div>
                          </div>
                          <div className='form-row'>
                          <div className="input-container">
                              <label htmlFor="email">Email</label>
                              <input
                                type="text"
                                id="email"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                onKeyDown={(e) => handleKeyDown(e, descriptionInputRef)}
                                ref={emailInputRef}
                              />
                            </div>
                          </div>
                          <div className="form-row end-distance">
                            <div className="input-container">
                              <label htmlFor="description">Mô tả</label>
                              <textarea
                                id="description"
                                value={description}
                                onChange={(e) => setDescription(e.target.value)}
                                ref={descriptionInputRef}
                              ></textarea>
                            </div>
                          </div>
                          <h1 className='personinfo-headerText top-border'>Thông tin trung tâm</h1>
                          <div className="form-row">
                            <div className="input-container distance">
                              <label htmlFor="inspectionStation">Trạm đăng kiểm</label>
                              <input
                                type="text"
                                id="inspectionStation"
                                value={companyInfo.inspectionStation}
                                title='Không thể sửa đổi'
                                className='input-disabled'
                                disabled
                              />
                            </div>
                            <div className="input-container">
                              <label htmlFor="stationCode">Mã số trạm</label>
                              <input
                                type="text"
                                id="stationCode"
                                value={companyInfo.stationCode}
                                title='Không thể sửa đổi'
                                className='input-disabled'
                                disabled
                              />
                            </div>
                          </div>
                          <div className="form-row">
                            <div className="input-container distance">
                              <label htmlFor="stationManager">Quản lý trạm</label>
                              <input
                                type="text"
                                id="stationManager"
                                value={companyInfo.stationManager}
                                title='Không thể sửa đổi'
                                className='input-disabled'
                                disabled
                              />
                            </div>
                            <div className="input-container">
                              <label htmlFor="hotline">Hotline</label>
                              <input
                                type="text"
                                id="hotline"
                                value={companyInfo.hotline}
                                title='Không thể sửa đổi'
                                className='input-disabled'
                                disabled
                              />
                            </div>
                          </div>
                          <div className="form-row">
                            <div className="button-container">
                              <label htmlFor='button-u' className='app-content-headerButton-u'>Cập nhật</label>
                              <button id='button-u' className='button-update' type="button" onClick={handleUpdate} style={{ 'display': 'none' }} />
                              <label htmlFor='button-c' className='app-content-headerButton-c'>Hủy</label>
                              <button id='button-c' className='button-cancel' type="button" onClick={handleCancel} style={{ 'display': 'none' }} />
                            </div>
                          </div>
                
                        </form>
                      </div>
                    ) : <ChangePassword/>}
                </div>
        </div>
    );
}

export default ProfileContent;