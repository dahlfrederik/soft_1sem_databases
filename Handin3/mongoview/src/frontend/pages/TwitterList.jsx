import React, { Component } from 'react'
import ReactTable from 'react-table-6'
import api from '../api'

import styled from 'styled-components'

import 'react-table-6/react-table.css'

const Wrapper = styled.div`
    padding: 0 40px 40px 40px;
`

class TwitterList extends Component {
    constructor(props) {
        super(props)
        this.state = {
            tweets: [],
            columns: [],
            isLoading: false,
        }
    }

    componentDidMount = async () => {
        this.setState({ isLoading: true })

        await api.getAllTweets().then(tweets => {
            this.setState({
                tweets: tweets.data.data,
                isLoading: false,
            })
           
        })
    }

    render() {
        const { tweets, isLoading } = this.state
        console.log('TCL: TweetsList -> render -> tweets', tweets)

        const columns = [
            {
                Header: 'ID',
                accessor: '_id',
                filterable: true,
            },
            {
                Header: 'Text',
                accessor: 'text',
                filterable: true,
            },
            {
                Header: 'User',
                accessor: 'user.name',
                filterable: true,
            },
            {
                Header: 'Retweets',
                accessor: 'retweet_count',
                filterable: true,
            },
           
           
        ]

        let showTable = true
        if (!tweets.length) {
            showTable = false
        }

        return (
            <Wrapper>
                {showTable && (
                    <ReactTable
                        data={tweets}
                        columns={columns}
                        loading={isLoading}
                        defaultPageSize={10}
                        showPageSizeOptions={true}
                        minRows={0}
                    />
                )}
            </Wrapper>
        )
    }
}

export default TwitterList