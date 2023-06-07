import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import Developers from './pages/DevelopersPage/Developers';
import News from './pages/NewsPage/News';
import Services from './pages/ServicesPage/Services';
import Search from './pages/SearchPage/Search';
import Dashboard from "./pages/Dashboard/Dashboard";

import { 
    createBrowserRouter,
    RouterProvider,
  } from 'react-router-dom';

  const currentUser = localStorage.getItem('currentUser');
  const token = localStorage.getItem('token');

  const router = createBrowserRouter([
    {
      path: '/',
      element: <App /> 
    },
    {
      path: '/developers',
      element: <Developers /> 
    },
    {
      path: '/news',
      element: <News /> 
    },
    {
      path: '/services',
      element: <Services /> 
    },
    {
      path: '/search',
      element: <Search /> 
    },
    {
      path: '/dashboard',
      element: <Dashboard currentUser={currentUser} token={token} />
    }
  ]);

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
);
