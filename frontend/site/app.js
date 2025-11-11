const apiBase = '/api'; // nginx proxies this to backend

async function fetchItems() {
  const res = await fetch(`${apiBase}/items`);
  if (!res.ok) throw new Error('Failed to fetch items');
  return res.json();
}

async function addItem(text) {
  const res = await fetch(`${apiBase}/items`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ text })
  });
  if (!res.ok) {
    const err = await res.text();
    throw new Error(err || 'Failed to add item');
  }
  return res.json();
}

async function render() {
  const list = document.getElementById('items');
  list.innerHTML = 'Loading...';
  try {
    const items = await fetchItems();
    list.innerHTML = '';
    if (items.length === 0) {
      list.innerHTML = '<li><em>No items</em></li>';
      return;
    }
    for (const it of items) {
      const li = document.createElement('li');
      li.textContent = `${it.id}: ${it.text}`;
      list.appendChild(li);
    }
  } catch (e) {
    list.innerHTML = `<li style="color:red">${e.message}</li>`;
  }
}

document.getElementById('addBtn').addEventListener('click', async () => {
  const input = document.getElementById('itemText');
  const text = input.value.trim();
  if (!text) return alert('Enter text');
  try {
    await addItem(text);
    input.value = '';
    await render();
  } catch (e) {
    alert('Error: ' + e.message);
  }
});

document.getElementById('healthBtn').addEventListener('click', async () => {
  const el = document.getElementById('healthResult');
  try {
    const res = await fetch(`${apiBase}/health`);
    const j = await res.json();
    el.textContent = JSON.stringify(j);
  } catch (e) {
    el.textContent = 'Health check failed: ' + e.message;
  }
});

// initial load
render();
