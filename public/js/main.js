(() => {
  // <stdin>
  var searchInput = document.getElementById("search");
  searchInput.addEventListener("input", () => {
    const query = searchInput.value.toLowerCase();
    document.querySelectorAll(".card").forEach((card) => {
      const title = card.querySelector("h2")?.innerText.toLowerCase() || "";
      card.style.display = title.includes(query) ? "" : "none";
    });
  });
})();
