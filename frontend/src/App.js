import React, {useState} from 'react';
import Home from './pages/HomePage/Home';
import Dashboard from "./pages/Dashboard/Dashboard";

function App() {
   const [loggedIn, setLoggedIn] = useState(
       localStorage.getItem('token') !== null
   );

  return (
    <div className='app'>
        {loggedIn ? <Dashboard /> : <Home />}
        {/*<Home />*/}
    </div>
  );
}

export default App;
