import { useState, useEffect } from "react"
import Trello from 'react-trello'

const INITIAL_STATE = { lanes: [] }

export function Board({ columns = [], tasks = [] }) {
  const [eventBus, setEventBus] = useState(null)

  useEffect(() => {
    if (eventBus && tasks.length) {

      const updatedLines = columns.reduce((acc, cur) => {
        const [id, title] = cur
        const cards = tasks.filter((item) => item.list_id === id)
        acc.lanes.push({
          id,
          title,
          style: { backgroundColor: '#f3f1f1' },
          cards
        })

        return acc

      }, { lanes: [] })

     
      eventBus.publish({type: 'REFRESH_BOARD', data: updatedLines})
    }
  }, [tasks, eventBus])

  return (
    <>
      <Trello
        data={INITIAL_STATE}
        draggable
        style={{backgroundColor: '#2a4bc5'}}
        eventBusHandle={(handle) => {
          setEventBus(handle)
        }}
      />
    </>
  )
}