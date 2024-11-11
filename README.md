# Draftsmith Python Client

Official Python bindings for Draftsmith's REST API.

## What is Draftsmith?

<p><img src="./assets/logo.png" style="float: left; width: 80px" /></p>

Draftsmith is a modern note-taking and task management system built with a focus on performance, type safety, and flexibility. It allows you to organize your thoughts, tasks, and knowledge in a hierarchical structure while maintaining relationships between different pieces of information through tags and parent-child relationships.

Most importantly, Draftsmith is hackable! It allows both client side scripting in [Rhai](https://rhai.rs/book/about/index.html) and client side scripting in Javascript with no HTML sanitization. This flexibility makes a great thinking space to tinker with ideas and automate workflows.

## Inspiration

I built Draftsmith because I used to love PHP scripts on Dokuwiki, I wanted a markdown and rust based version of that with a REST API so I could connect it to Vim and Emacs. Most importantly I wanted to be able to create macros like [Typst](https://typst.app/docs/) So I could automate things (easily) like this:

```rust
let g = gallery(
    "All PNG Files",
    list_assets(`*.png`));
g
```

Which gives me a gallery like this:

<details closed><summary>

HTML
</summary>

```html

<div class="max-w-4xl mx-auto p-6 border border-gray-200 rounded-lg shadow-md">
<h2 class="text-2xl font-bold">All PNG Files</h2>
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
    <div><img src="/m/1.png" class="gallery-image" /></div>
    <div><img src="/m/Screenshot_20241109-160513.png" class="gallery-image" /></div>
    <div><img src="/m/Screenshot_20241109-221933.png" class="gallery-image" /></div>
    <div><img src="/m/Screenshot_20241109-221939.png" class="gallery-image" /></div>
    <div><img src="/m/Screenshot_20241111-122941.png" class="gallery-image" /></div>
    <div><img src="/m/dor_bon_young.png" class="gallery-image" /></div>
    <div><img src="/m/icon.png" class="gallery-image" /></div>
    <div><img src="/m/signal-2024-10-15-153648_002.png" class="gallery-image" /></div>
    <div><img src="/m/swslhd.png" class="gallery-image" /></div>
    <div><img src="/m/t_wallpaper_2.png" class="gallery-image" /></div>
    <div><img src="/m/tmpzifq6fco.png" class="gallery-image" /></div>
    </div>
</div>
```
</details>


<details closed><summary>

Screenshot
</summary>

![Screenshot](./assets/gallery_screenshot.png)
</details>



## Architecture

Draftsmith follows a unique architectural approach:
- Core logic is implemented in Rust (backed by Postgresql), providing strong type safety, memory safety, and high performance
- A REST API exposes this functionality, allowing for flexible integrations
- Client applications (GUI, CLI, etc.) can be written in any language while benefiting from a stable, well-defined and performant backend

This separation allows:
- Core business logic to remain fast and reliable
- GUI development to use more flexible languages like Python or TypeScript
- CLI tools and aliases can be created easily.
- Type safety and correctness to be maintained across all interfaces

## Installation

```bash
pip install draftsmith-client
```

## Usage

```python
from draftsmith import note_create, get_notes_tree, create_task, TaskStatus

# Create a new note
note = note_create("Meeting Notes", "Discussion points for today's meeting")

# Create a task
task = create_task(CreateTaskRequest(
    status=TaskStatus.TODO,
    priority=1,
    all_day=False
))

# Get hierarchical view of all notes
notes_tree = get_notes_tree()
```

## Features

- Complete API coverage for Draftsmith's functionality
    - Full CRUD operations for notes, tasks, and tags
- Type-safe requests and responses using Pydantic models

## API Documentation

The client provides bindings for all Draftsmith REST API endpoints:

### Notes
- Create, read, update, and delete notes
- Manage note hierarchies
- Retrieve notes with or without content
- Get full note trees

### Tasks
- Create and manage tasks
- Set status, priority, and deadlines
- Organize tasks in hierarchies
- Track effort estimates and actual effort

### Tags
- Create and manage tags
- Attach tags to notes
- Organize tags in hierarchies
- Get tagged items in tree structure

## Development

To run tests:

```bash
pytest python_client/test_main.py
```

## License

GPL License
