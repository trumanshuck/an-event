let ticking = false;
let postslug = null;
let lastIdx = 0;

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

  const idx = Number(topPost.dataset.idx)
  if (postslug === topPost.dataset.postslug || idx < lastIdx) {
    ticking = false
    return
  }

  postslug = topPost.dataset.postslug
  lastIdx = idx

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
    body: JSON.stringify({ postslug })
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

