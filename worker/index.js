export default {
  fetch(request, env) {
    const url = new URL(request.url);
    url.hostname = env.TARGET_URL_HOSTNAME;
    return fetch(url.toString(), request);
  },
};
