import React, { Component } from 'react'
import styled from 'styled-components'
import cat from '../images/cat.jpg'

const Wrapper = styled.a.attrs({
    className: 'navbar-brand',
})``

class Logo extends Component {
    render() {
        return (
            <Wrapper>
                <img src={cat} width="50" height="50" />
            </Wrapper>
        )
    }
}

export default Logo