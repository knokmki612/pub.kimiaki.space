export default {
  fetch(request) {
    const proxyRequest = new Request(new URL(request.url, PROXY_URL_BASE), {
      body: request.body,
      headers: request.headers,
      method: request.method,
      redirect: request.redirect,
    });
    return fetch(proxyRequest);
  },
};
