export default {
  fetch(request, env) {
    const url = new URL(request.url);
    url.hostname = env.PROXY_URL_BASE;
    return fetch(url.toString(), request);
  },
};
