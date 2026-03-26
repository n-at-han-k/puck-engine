import { Puck } from "@puckeditor/core";
import React from "react";
import { createRoot } from "react-dom";

// Default component configuration
const defaultConfig = {
  components: {
    Heading: {
      fields: {
        text: { type: "text" },
        level: {
          type: "select",
          options: [
            { label: "H1", value: "1" },
            { label: "H2", value: "2" },
            { label: "H3", value: "3" },
            { label: "H4", value: "4" },
            { label: "H5", value: "5" },
            { label: "H6", value: "6" },
          ],
        },
      },
      defaultProps: {
        text: "Heading",
        level: "2",
      },
      render: ({ text, level }) => {
        const Tag = `h${level}`;
        return React.createElement(Tag, {}, text);
      },
    },
    Paragraph: {
      fields: {
        text: { type: "textarea" },
      },
      defaultProps: {
        text: "Lorem ipsum dolor sit amet",
      },
      render: ({ text }) => {
        return React.createElement("p", {}, text);
      },
    },
    Button: {
      fields: {
        label: { type: "text" },
        href: { type: "text" },
        variant: {
          type: "select",
          options: [
            { label: "Primary", value: "primary" },
            { label: "Secondary", value: "secondary" },
          ],
        },
      },
      defaultProps: {
        label: "Click me",
        href: "#",
        variant: "primary",
      },
      render: ({ label, href, variant }) => {
        return React.createElement(
          "a",
          { href, className: `btn btn-${variant}` },
          label
        );
      },
    },
    Card: {
      fields: {
        title: { type: "text" },
        description: { type: "textarea" },
      },
      defaultProps: {
        title: "Card Title",
        description: "Card description text goes here",
      },
      render: ({ title, description }) => {
        return React.createElement("div", { className: "card" }, [
          React.createElement("h3", { key: "title" }, title),
          React.createElement("p", { key: "desc" }, description),
        ]);
      },
    },
  },
};

// Initialize editor
function initPuckEditor() {
  const container = document.querySelector("[data-controller='puck-editor']");
  if (!container) return;

  const editorContainer = container.querySelector("[data-puck-editor-target='container']");
  const pageId = editorContainer.dataset.pageId;
  const pageData = JSON.parse(editorContainer.dataset.pageData || "{}");
  
  // Get custom components from data attribute
  let customComponents = {};
  try {
    const componentsData = JSON.parse(editorContainer.dataset.components || "[]");
    // Convert array to object format expected by Puck
    componentsData.forEach((comp) => {
      customComponents[comp.name] = {
        fields: comp.fields || {},
        defaultProps: comp.default_props || {},
        render: createComponentRenderer(comp),
      };
    });
  } catch (e) {
    console.error("Error parsing components:", e);
  }

  // Merge default and custom components
  const config = {
    ...defaultConfig,
    components: {
      ...defaultConfig.components,
      ...customComponents,
    },
  };

  const root = createRoot(document.getElementById("puck-root"));
  
  const handlePublish = async (data) => {
    try {
      const csrfToken = document.querySelector('meta[name="csrf-token"]')?.content;
      const response = await fetch(`/puck/editor/${pageId}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken,
        },
        body: JSON.stringify({
          page: {
            puck_data: data,
          },
        }),
      });

      const result = await response.json();
      if (result.success) {
        alert("Page saved successfully!");
      } else {
        alert("Error saving page: " + (result.errors?.join(", ") || "Unknown error"));
      }
    } catch (error) {
      console.error("Error saving page:", error);
      alert("Error saving page");
    }
  };

  root.render(
    React.createElement(Puck, {
      config: config,
      data: pageData,
      onPublish: handlePublish,
    })
  );
}

// Create a renderer function from component definition
function createComponentRenderer(component) {
  return (props) => {
    // For now, return a simple div with the component name
    // In a real implementation, you would compile the React component
    return React.createElement("div", {
      className: `puck-component puck-component-${component.name.toLowerCase()}`,
      "data-component": component.name,
    }, component.name);
  };
}

// Initialize when DOM is ready
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", initPuckEditor);
} else {
  initPuckEditor();
}
