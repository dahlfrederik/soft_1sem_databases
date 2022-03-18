import React from 'react'
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom'

import { NavBar } from '../components'
import { TwitterList, TweetInsert, Home} from '../pages'

import 'bootstrap/dist/css/bootstrap.min.css'

function App() {
    return (
        <Router>
            <NavBar />
            <Routes>

                <Route path="/twitter/list" exact element={<TwitterList/>} />
                <Route path="/twitter/create" exact element={<TweetInsert/>} />
                <Route path="/" exact element={<Home/>} />
              
            </Routes>
        </Router>
    )
}

export default App