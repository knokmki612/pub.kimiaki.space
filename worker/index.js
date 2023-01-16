export default {
  fetch(request, env) {
    const proxyRequest = new Request(new URL(request.url, env.PROXY_URL_BASE), {
      body: request.body,
      headers: request.headers,
      method: request.method,
      redirect: request.redirect,
    });
    return fetch(proxyRequest);
  },
};
