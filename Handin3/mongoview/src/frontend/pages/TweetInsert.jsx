import React, { Component } from 'react'
import api from '../api'

import styled from 'styled-components'

const Title = styled.h1.attrs({
    className: 'h1',
})``

const Wrapper = styled.div.attrs({
    className: 'form-group',
})`
    margin: 0 30px;
`

const Label = styled.label`
    margin: 5px;
`

const InputText = styled.input.attrs({
    className: 'form-control',
})`
    margin: 5px;
`

const Button = styled.button.attrs({
    className: `btn btn-primary`,
})`
    margin: 15px 15px 15px 5px;
`

const CancelButton = styled.a.attrs({
    className: `btn btn-danger`,
})`
    margin: 15px 15px 15px 5px;
`

class TwitterInsert extends Component {
    constructor(props) {
        super(props)
        this.state = {
            text: '',
            user: {name: ''},
            retweet_count: 0
        }
    }

    handleChangeInputText = async event => {
        const text = event.target.value
        this.setState({ text })
    }

    handleChangeInputUsername = async event => {
        const username = event.target.value
        this.setState({ user: {name: username} })
    }

   

    handleIncludeTweet = async () => {   
        await api.insertTweet(this.state).then(res => {
            window.alert(`Tweet inserted successfully`)
            this.setState({
                text: '',
                user: {name: ''},
                retweet_count: 0
            })
        })
    }

    render() {
        const { info } = this.state
        return (
            <Wrapper>
                <Title>Create Tweet</Title>

                <Label>Username: </Label>
                <InputText
                    type="text"
                    value={info}
                    onChange={this.handleChangeInputText}
                />
                
                <Label>Tweet: </Label>
                <InputText
                    type="text"
                    value={info}
                    onChange={this.handleChangeInputUsername}
                />

        

                <Button onClick={this.handleIncludeTweet}>Add Movie</Button>
                <CancelButton href={'/twitter/list'}>Cancel</CancelButton>
            </Wrapper>
        )
    }
}

export default TwitterInsert