const WebSocket = require('ws');
const server = new WebSocket.Server({ port: 8080 });

const symbols = ['AAPL', 'GOOGL', 'AMZN'];

function getRandomTrade() {
  return {
    symbol: symbols[Math.floor(Math.random() * symbols.length)],
    price: (Math.random() * 1000).toFixed(2),
    quantity: Math.floor(Math.random() * 100) + 1,
  };
}

server.on('connection', (ws) => {
  console.log('Client connected');
  const intervalId = setInterval(() => {
    ws.send(JSON.stringify([getRandomTrade()]));
  }, 1000); // Send a new trade every second

  ws.on('close', () => {
    console.log('Client disconnected');
    clearInterval(intervalId);
  });
});

console.log('WebSocket server is running on ws://localhost:8080');
