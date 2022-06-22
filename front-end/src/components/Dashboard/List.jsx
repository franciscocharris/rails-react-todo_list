import Board from 'react-trello'

export function List() {
  const data = {
    lanes: [
      {
        
        id: 'lane1',
        title: 'NOT STARTED',
        style: { backgroundColor: '#f3f1f1' },
        label: '2/2',
        cards: [
          {id: 'Card1', title: 'Write Blog', description: 'Can AI make memes', label: '30 mins', draggable: true},
          {id: 'Card2', title: 'Pay Rent', description: 'Transfer via NEFT', label: '5 mins', metadata: {sha: 'be312a1'}}
        ]
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