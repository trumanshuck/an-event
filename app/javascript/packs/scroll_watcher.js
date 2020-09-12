let ticking = false;
let stopslug = null;
let postslug = null;

function notifyScroll() {
  if (ticking) {
    return
  }

  const posts = document.getElementsByClassName("post");
  if (posts.length === 0) {
    ticking = false
    return
  }
  ticking = true

  const topPost = Array.from(posts).reduce((closest, current) => {
    if (closest === null || Math.abs(current.getBoundingClientRect().top) < Math.abs(closest.getBoundingClientRect().top)) {
      return current
    }
    return closest
  }, null)

  if (stopslug === topPost.dataset.stopslug && postslug === topPost.dataset.postslug) {
    ticking = false
    return
  }

  stopslug = topPost.dataset.stopslug
  postslug = topPost.dataset.postslug

  const token = document.getElementsByName(
    "csrf-token"
  )[0].content;

  fetch("/posts/viewed-post", {
    method: 'POST',
    mode: 'cors',
    cache: 'no-cache',
    credentials: 'same-origin',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    },
    body: JSON.stringify({ stopslug, postslug })
  }).then(() => {
    ticking = false
  }).finally(() => {
    ticking = false
  })
}

document.addEventListener("turbolinks:load", () => {
  window.removeEventListener('scroll', notifyScroll);
  window.addEventListener('scroll', notifyScroll);
})

