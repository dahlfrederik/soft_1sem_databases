import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import styled from 'styled-components'

const Collapse = styled.div.attrs({
    className: 'collpase navbar-collapse',
})``

const List = styled.div.attrs({
    className: 'navbar-nav mr-auto',
})``

const Item = styled.div.attrs({
    className: 'collpase navbar-collapse',
})``

class Links extends Component {
    render() {
        return (
            <React.Fragment>
                <Link to="/" className="navbar-brand">
                    Twitter information (Handin3)
                </Link>
                <Collapse>
                    <List>
                        <Item>
                            <Link to="/twitter/list" className="nav-link">
                                List Top 10 tweets
                            </Link>
                        </Item>
                        <Item>
                            <Link to="/twitter/create" className="nav-link">
                                Create Tweet
                            </Link>
                        </Item>
                    </List>
                </Collapse>
            </React.Fragment>
        )
    }
}

export default Links