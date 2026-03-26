import { Render } from "@puckeditor/core";
import React from "react";
import { createRoot } from "react-dom";

// Same component configuration as the editor
const config = {
  components: {
    Heading: {
      render: ({ text, level }) => {
        const Tag = `h${level || 2}`;
        return React.createElement(Tag, {}, text);
      },
    },
    Paragraph: {
      render: ({ text }) => {
        return React.createElement("p", {}, text);
      },
    },
    Button: {
      render: ({ label, href, variant }) => {
        return React.createElement(
          "a",
          { href: href || "#", className: `btn btn-${variant || "primary"}` },
          label || "Click me"
        );
      },
    },
    Card: {
      render: ({ title, description }) => {
        return React.createElement("div", { className: "card" }, [
          React.createElement("h3", { key: "title" }, title || "Card Title"),
          React.createElement("p", { key: "desc" }, description || "Card description"),
        ]);
      },
    },
  },
};

// Initialize page render
function initPuckRender() {
  const container = document.querySelector("[data-controller='puck-render']");
  if (!container) return;

  const renderRoot = container.querySelector("[data-puck-render-target='root']");
  const pageData = JSON.parse(renderRoot.dataset.pageData || "{}");

  const root = createRoot(document.getElementById("puck-render-root"));
  
  root.render(
    React.createElement(Render, {
      config: config,
      data: pageData,
    })
  );
}

// Initialize when DOM is ready
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", initPuckRender);
} else {
  initPuckRender();
}
