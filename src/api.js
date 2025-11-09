export const API_URL = "https://multi-module-backend.onrender.com";

export async function getUsers() {
  const response = await fetch(`${API_URL}/admin/users`);
  return response.json();
}
