import Board from 'react-trello'

const data = {
  lanes: [
    {
      id: 'lane1',
      title: 'NOT STARTED',
      style: { backgroundColor: '#f3f1f1' },
      label: '0/0',
      cards: []
    },
    {
      id: 'lane2',
      title: 'IN PROGRESS',
      style: { backgroundColor: '#f3f1f1' },
      label: '0/0',
      cards: []
    },
    {
      id: 'lane3',
      title: 'COMPLETED',
      style: { backgroundColor: '#f3f1f1' },
      label: '0/0',
      cards: []
    }
  ]
}

export function List() {

  return (
    <>
      <Board
        data={data}
        draggable
        style={{backgroundColor: '#2a4bc5'}}
      />
    
    </>
  )
}