import React, {useState, useRef} from 'react';
import './PersonInfo.css';

function PersonInfo(props) {
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));

    const [fullName, setFullName] = useState(currentUser.last_name + ' ' + currentUser.first_name);
    const [gender, setGender] = useState('Chưa xác định <(\")');
    const [dateOfBirth, setDateOfBirth] = useState("Không có");
    const [phoneNumber, setPhoneNumber] = useState(currentUser.phone_number);
    const [citizenId, setCitizenId] = useState(currentUser.identity_no);
    const [email, setEmail] = useState(currentUser.gmail);
    const [description, setDescription] = useState("Dăm ba con web <(\")");
    const [companyInfo, setCompanyInfo] = useState({
      inspectionStation: "TTDK XCG 1101S - Hà Nội",
      stationCode: "1101S",
      stationManager: "Đinh Ngọc Hiến",
      hotline: "02063758742",
    });
    const [successMessage, setSuccessMessage] = useState("");
  
    const fullNameInputRef = useRef(null);
    const dateOfBirthInputRef = useRef(null);
    const phoneNumberInputRef = useRef(null);
    const citizenIdInputRef = useRef(null);
    const emailInputRef = useRef(null);
    const descriptionInputRef = useRef(null);
  
    const handleUpdate = () => {
      if (!fullName || !phoneNumber || !citizenId || !dateOfBirth) {
        setSuccessMessage("Vui lòng không được để trống");
        return;
      }
  
      setSuccessMessage("Cập nhật thành công");
      // Code cập nhật thông tin
    };
  
    const handleCancel = () => {
      setFullName("Hoàn Bằng");
      setDateOfBirth("15/11/2002");
      setPhoneNumber("0388586955");
      setCitizenId("000123456789");
      setEmail("");
      setDescription("");
      setSuccessMessage("");
    };
  
    const handleKeyDown = (event, nextInputRef) => {
      if (event.key === "Enter") {
        event.preventDefault();
        nextInputRef.current.focus();
      }
    };
  
    return (
      <div className="personinfo-container">
        <form>
          <h1 className='personinfo-headerText'>Thông tin cá nhân</h1>
          <div className="form-row">
            <div className="input-container distance">
              <label htmlFor="fullName">Họ và tên</label>
              <input
                type="text"
                id="fullName"
                value={fullName}
                onChange={(e) => setFullName(e.target.value)}
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
                          checked
                      />
                      <p>Nam</p>
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
                      />
                      <p>Nữ</p>
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
              <button className='button-update' type="button" onClick={handleUpdate}>
                Cập nhật
              </button>
              <button className='button-cancel' type="button" onClick={handleCancel}>
                Hủy bỏ
              </button>
            </div>
            {successMessage && (
              <div className="success-message">{successMessage}</div>
            )}
          </div>

        </form>
      </div>
    );
}

export default PersonInfo;