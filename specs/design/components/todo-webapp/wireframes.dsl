// Todo webapp — single-role personal task manager

screen TaskList "Signed-in user views and manages their personal task list"
  navbar "Todo"
  row
    heading "My Tasks"
    right
    search "Search tasks…"
  row
    input "Add a new task…"
    button "Add task" primary
  heading "Active"
  table "Task | Added" -> TaskDetail
    row "Buy groceries | 2h ago"
    row "Finish PRD review | 1d ago"
    row "Call the plumber | 3d ago"
  heading "Completed"
  table "Task | Completed"
    row "Book dentist appointment | Yesterday"
    row "Renew library card | 3 days ago"

screen TaskDetail "Edit a single task's text or completed state"
  navbar "Todo"
  breadcrumb "My Tasks / Edit task"
  heading "Edit Task"
  textarea "Buy groceries"
  checkbox "Mark as completed"
  row
    right
    button "Delete" danger
    button "Cancel" -> TaskList
    button "Save" primary -> TaskList
