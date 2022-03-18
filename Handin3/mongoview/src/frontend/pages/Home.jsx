import React, { Component } from 'react'
import styled from 'styled-components'
const Title = styled.h1.attrs({
    className: 'h1',
})``

const Wrapper = styled.div.attrs({
    className: 'form-group',
})`
    margin: 0 30px;
`

const Text = styled.div.attrs({
    className: 'h4',
})``

class Home extends Component {
    constructor(props) {
        super(props)
        
    }

    render() {
        return (
            <Wrapper>
                <Title>List top 10 tweets, or save your own to the database!</Title>
                <Text>Handin 3, studienumre??</Text>
             
            </Wrapper>
        )
    }
}

export default Home