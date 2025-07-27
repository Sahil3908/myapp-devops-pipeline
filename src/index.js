const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('🚀 Hello from Node.js App deployed with Terraform, Ansible, and Docker!');
});

// Bind to 0.0.0.0 so it can be accessed from outside the Docker container
app.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ Server is running on http://0.0.0.0:${PORT}`);
});

