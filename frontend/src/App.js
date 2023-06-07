import React, {useState} from 'react';
import Home from './pages/HomePage/Home';

function App() {
   // const [loggedIn, setLoggedIn] = useState(
   //     localStorage.getItem('token') !== null
   // )

   // let token = null;
   // let currentUser = null;
   //
   // const handleLoggedIn = () => {
   //     token = localStorage.getItem('token');
   //     currentUser = localStorage.getItem('currentUser');
   //     setLoggedIn(!loggedIn);
   // }

  return (
    <div className='app'>
        <Home />
    </div>
  );
}

export default App;
