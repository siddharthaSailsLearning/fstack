const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2/promise');

const {
  DB_HOST = 'db',
  DB_PORT = 3306,
  DB_USER = 'appuser',
  DB_PASSWORD = 'apppass',
  DB_NAME = 'appdb'
} = process.env;

let pool;

(async () => {
  try {
    pool = await mysql.createPool({
      host: DB_HOST,
      port: DB_PORT,
      user: DB_USER,
      password: DB_PASSWORD,
      database: DB_NAME,
      waitForConnections: true,
      connectionLimit: 10
    });
    console.log('✅ Connected to MySQL');
  } catch (err) {
    console.error('❌ DB Connection Error:', err.message);
  }
})();

const app = express();
app.use(bodyParser.json());

// Health endpoint
app.get('/api/health', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT 1+1 AS result');
    res.json({ ok: true, db: rows[0].result });
  } catch (err) {
    res.status(500).json({ ok: false, error: err.message });
  }
});

// Get items
app.get('/api/items', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT id, text FROM items ORDER BY id ASC');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: 'Failed to fetch items' });
  }
});

// Add item
app.post('/api/items', async (req, res) => {
  const { text } = req.body;
  if (!text) return res.status(400).json({ error: 'text is required' });
  try {
    const [result] = await pool.query('INSERT INTO items (text) VALUES (?)', [text]);
    res.status(201).json({ id: result.insertId, text });
  } catch (err) {
    res.status(500).json({ error: 'Failed to insert item' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 Backend running on port ${PORT}`));
