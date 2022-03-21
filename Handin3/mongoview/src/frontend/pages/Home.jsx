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
                <br/>
                <h1>HANDIN 3</h1>
                <h3>Gruppe medlemmer </h3>
                    <p>Josef Marc | jp-325</p>
                    <p>Sebastian Bentley | sb-287</p>
                    <p> Frederik Dinsen | fd-77</p>
                    <p> Frederik Dahl | fd-76 </p>
 
             
            </Wrapper>
        )
    }
}

export default Home