import React from 'react'
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom'

import { NavBar } from '../components'
import { MoviesList, MoviesInsert} from '../pages'

import 'bootstrap/dist/css/bootstrap.min.css'

function App() {
    return (
        <Router>
            <NavBar />
            <Routes>

                <Route path="/movies/list" exact element={<MoviesList/>} />
                <Route path="/movies/create" exact element={<MoviesInsert/>} />
              
            </Routes>
        </Router>
    )
}

export default App