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

class MoviesInsert extends Component {
    constructor(props) {
        super(props)
        this.state = {
            title: '',
        }
    }

    handleChangeInputName = async event => {
        const title = event.target.value
        this.setState({ title })
    }

    handleChangeInputRating = async event => {
        const rating = event.target.validity.valid
            ? event.target.value
            : this.state.rating

        this.setState({ rating })
    }

    handleChangeInputTime = async event => {
        const time = event.target.value
        this.setState({ time })
    }

    handleIncludeMovie = async () => {   
        await api.insertMovie(this.state).then(res => {
            window.alert(`Movie inserted successfully`)
            this.setState({
                title: '',
               
            })
        })
    }

    render() {
        const { title } = this.state
        return (
            <Wrapper>
                <Title>Create Movie</Title>

                <Label>Title: </Label>
                <InputText
                    type="text"
                    value={title}
                    onChange={this.handleChangeInputName}
                />

        

                <Button onClick={this.handleIncludeMovie}>Add Movie</Button>
                <CancelButton href={'/movies/list'}>Cancel</CancelButton>
            </Wrapper>
        )
    }
}

export default MoviesInsert