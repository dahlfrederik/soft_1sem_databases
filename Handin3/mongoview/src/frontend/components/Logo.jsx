import React, { Component } from 'react'
import styled from 'styled-components'



const Wrapper = styled.a.attrs({
    className: 'navbar-brand',
})``

class Logo extends Component {
    render() {
        return (
            <Wrapper>
                <img src={"src/frontend/images/cat.jpg"} width="50" height="50" />
            </Wrapper>
        )
    }
}

export default Logo