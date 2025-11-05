Project: Shift_AI

This file records the changes made by the Gemini AI assistant.

- 2025-10-29: Created `add_sample_open_shifts.sql` to add sample data for the bulletin board (掲示板).

- 2025-10-21: Created this README.txt file to track project modifications.
- 2025-10-21: Modified `UserBean.java` to include `username` and `roleName` fields.
- 2025-10-21: Fixed database schema mismatch in `UserListServlet.java` and updated `users.jsp` to display correct user information.
- 2025-10-21: Removed broken links to `department_list.jsp` from `admin_home.jsp` and `developer_home.jsp`
- 2025-10-21: Addressed role handling inconsistency by setting `role` in session in `LoginExecuteAction.java` and updating role checks in `HomeAdminAction.java`, `HomeDeveloperAction.java`, and `HomeUserAction.java`.
- 2025-10-21: Removed the 'Forgot password' link from `login.jsp` as per user's request.
- 2025-10-21: Created `src/shift_manager/OpenShiftsAction.java` to display open shifts.
- 2025-10-21: Created `src/shift_manager/ApplyShiftExecuteAction.java` to handle applying for open shifts.
- 2025-10-21: Created `WebContent/shift_manager/open_shifts.jsp` for the UI of open shifts.

- 2025-10-22: **Homepage UI/UX Improvement & Calendar Functionality:**
    - Modernized `user_home.jsp`, `admin_home.jsp`, `developer_home.jsp` with updated CSS and Font Awesome icons for a consistent look.
    - Implemented a dynamic, real-time calendar with month navigation in `user_home.jsp` using JavaScript.
    - Ensured consistent footer navigation across `user_home.jsp`, `menu.jsp`, `notice.jsp`, and `open_shifts.jsp`.

- 2025-10-22: **Notice System Integration:**
    - Integrated `NoticeBean.java` and `NoticeDAO.java` (updated for `isRead` field and `addNotice`, `getRecentNotices` methods).
    - Created `WebContent/admin/add_notice.jsp` and `src/admin/AddNoticeAction.java` for administrators to add new notices.
    - Created `src/notice/NoticeListAction.java` and updated `WebContent/noticafition/notice.jsp` to display a list of notices fetched from the database.
    - Created `src/notice/MarkAllReadAction.java` to handle marking all notices as read.
    - Updated navigation links in `WebContent/menu/menu.jsp` and `WebContent/noticafition/notice.jsp` to point to the correct notice actions.
    - Removed recent notices display from `user_home.jsp` and the associated `src/home/HomeNoticeAction.java` (this was a previous change, not a new one).

- 2025-10-22: **Database Schema Update & Compatibility:**
    - Provided a comprehensive SQL script (`shift_ai_db.sql`) to update the database schema to support the integrated `TeamGShift` functionality (including `role` table, modifications to `account`, `company`, `user`, `shift` tables).
    - Assisted with debugging database schema issues and provided `INSERT` statements for `company` data.
    - Updated `src/loginlogout/LoginExecuteAction.java` to correctly use `roleId` from `AccountBean` and fetch `roleName` from the `role` table.

- 2025-10-22: **Shift List Page Layout:**
    - Applied a modern and consistent layout to `WebContent/shift_manager/open_shifts.jsp`.

- 2025-10-23: **Interactive Calendar Update:**
    - Overhauled calendar JavaScript in `user_home.jsp` to fix click event issues by attaching listeners directly to date cells.
    - Added a new feature to visually circle the selected date on the calendar.
    - Ensured shift details are correctly displayed upon selection and cleared when navigating between months.

- 2025-10-23: **Bug Fix:**
    - Patched `LoginExecuteAction.java` to ensure the admin user is always redirected to the admin homepage, overriding incorrect role data from the database.

- 2025-10-23: **Project-Wide Review and Refactoring:**
    - Conducted a full code review to identify and fix bugs and inconsistencies.
    - Completed translation of all remaining Vietnamese text to Japanese in source files and JSPs.
    - Refactored `ShiftDAO.java` to fix critical bugs including incorrect SQL table names, faulty month logic, and data type mismatches.
    - Restored `ShiftBean.java` to its correct state with all necessary fields and data types to ensure application-wide data consistency.
    - Removed redundant and incorrect shift fetching logic from `HomeUserAction.java` as calendar data is now fetched dynamically by JavaScript.
    - Cleaned up `HomeUserAction.java` by removing unused imports and local variables, resolving compiler warnings.
    - Fixed 404 Not Found error for calendar data by ensuring correct context path resolution in `user_home.jsp`'s JavaScript fetch call.

- 2025-10-24: **Troubleshooting & System Integration:**
    - Diagnosed and fixed a complex data display issue (`~` for time) by identifying and resolving a Java compiler version mismatch (Java 15 vs. Java 8) and a resulting syntax incompatibility (Text Blocks) in `ShiftDAO.java`.
    - Corrected a critical SQL bug in `ShiftDAO.java` by quoting the reserved keyword `status` with backticks.
    - Fixed the calendar's selected-day circle being "stuck" on the current date by resolving a CSS class conflict in `user_home.jsp`.
    - Integrated new `mypage.jsp` and `password_change.jsp` pages into the application.
    - Updated main navigation menus across 6 files, replacing the "Logout" link with a "My Page" link.
    - Refactored `mypage.jsp` and `password_change.jsp` to use the standard application layout and shared stylesheet for a consistent UI, width, and feel.
    - Cleaned up obsolete CSS files to improve project structure.

- 2025-10-24: **Shift Display Fixes:**
    - Fixed `ShiftListExecuteAction.java` to correctly join the `department` table and retrieve `dept_name`.
    - Updated `ListShift.jsp` to display the `dept_name` for each shift.
    - User confirmed resolution of time display issue (`~`) and `deptName` display issue (`false`) on `user_home.jsp` after manual intervention and implied recompilation/re-deployment. The underlying cause was likely a build/deployment mismatch where an older, buggy version of `GetShiftsForMonthAction.class` was being used.

- 2025-10-24: **Responsive Design Reversion & Width Adjustment:**
    - Reverted previous responsive design changes by deleting `WebContent/css/responsive.css` and removing its link from `WebContent/home/user_home.jsp`.
    - Increased the `max-width` of the main `.container` in `WebContent/home/css/style.css` to `768px` to provide more horizontal space and prevent text wrapping issues (e.g., “処理一覧”).

- 2025-10-24: **Implemented "Urgent Shift Request" / "掲示板" feature:**
    - **Database Schema Update (SQL provided to user):** `shift.user_id` made nullable, `shift.status` enum updated with `'募集'`.
    - **`ShiftDAO.java`:** Added `addShift`, `getOpenShifts`, `applyForShift` methods.
    - **`DepartmentBean.java`:** Created.
    - **`DepartmentDAO.java`:** Created.
    - **`AddUrgentShiftAction.java`:** Created (admin action to add urgent shifts).
    - **`add_urgent_shift.jsp`:** Created (admin form to add urgent shifts).
    - **`ListUrgentShiftsAction.java`:** Created (admin action to list urgent shifts).
    - **`list_urgent_shifts.jsp`:** Created (admin page to list urgent shifts).
    - **`admin_home.jsp`:** Modified to include "掲示板" link and adjust layout to 2x2 grid (シフト管理, ユーザー管理 on row 1; 掲示板, お知らせ on row 2).
    - **`WebContent/home/css/style.css`:** Modified for `admin-menu` layout.
    - **`OpenShiftsAction.java`:** Updated to use `ShiftDAO.getOpenShifts()`.
    - **`ApplyShiftExecuteAction.java`:** Updated to use `ShiftDAO.applyForShift()`.

- 2025-10-27: **Feature: User Shift Submission Flow (Phần 1 - Chọn kỳ nộp lịch)**
    - **Tái cấu trúc Menu & Điều hướng:**
        - Chuẩn hóa `WebContent/menu/menu.jsp` để có menu điều hướng nhất quán trên toàn ứng dụng.
        - Tạo `WebContent/noticafition/notice_menu.jsp` làm trung tâm cho các thông báo.
        - Cập nhật `WebContent/noticafition/notice.jsp`, `WebContent/home/user_home.jsp`, `WebContent/shift_manager/open_shifts.jsp` để sử dụng `menu.jsp` chuẩn.
        - Sửa lỗi đường dẫn 404 cho "処理一覧" bằng cách trỏ đến `shift/ShiftListAction`.
    - **Chức năng Nộp lịch làm việc (User) - Chọn kỳ nộp lịch:**
        - Tạo `src/bean/SubmissionPeriodBean.java` để quản lý dữ liệu kỳ nộp.
        - Viết lại `src/shift/AddShiftAction.java` để tính toán và hiển thị các kỳ nộp lịch còn hạn dựa trên ngày hiện tại.
        - Viết lại `WebContent/addshift/addshift.jsp` để hiển thị danh sách các kỳ nộp lịch còn hạn.
        - Di chuyển nút "シフト提出" trên `user_home.jsp` xuống cuối trang, phía trên menu chân trang.
    - **Chức năng Quản lý ca làm việc (Admin) - Xem ca đã nộp:**
        - Đổi tên liên kết "シフト管理" thành "シフト提出確認" trên `WebContent/home/admin_home.jsp`.
        - Tạo `src/admin/ListSubmittedShiftsAction.java` để hiển thị danh sách các ca làm việc đã nộp.
        - Tạo `WebContent/admin/submitted_shifts.jsp` để hiển thị danh sách này.
        - Cập nhật `src/dao/ShiftDAO.java` với phương thức `getShiftsByStatus`.
    - **Sửa lỗi và Refactor:**
        - Refactor `src/dao/ShiftDAO.java`: Đổi tên phương thức `addShift` thành `addOpenShift` (cho admin) và `addUserShift` (cho user) để tránh trùng lặp.
        - Cập nhật `src/admin/AddUrgentShiftAction.java` và `src/shift/AddShiftExecuteAction.java` để gọi đúng phương thức mới trong `ShiftDAO`.
        - Sửa lỗi `java.sql.Date` trong `src/shift/AddShiftExecuteAction.java`.
        - Xóa `import java.time.DayOfWeek;` không sử dụng trong `src/shift/AddShiftAction.java`.

- 2025-10-27: **Feature: User Shift Submission Flow (Phần 2 - Nhập chi tiết ca làm việc cho từng ngày)**
    - **Chức năng Nhập chi tiết ca làm việc cho từng ngày:**
        - Tạo `src/bean/ShiftEntryDayBean.java` để quản lý dữ liệu cho mỗi ngày trong kỳ.
        - Tạo `src/shift/EnterShiftsAction.java` để hiển thị danh sách các ngày trong một kỳ đã chọn.
        - Tạo `src/shift/EditDayAction.java` để hiển thị biểu mẫu nhập chi tiết ca làm việc cho một ngày cụ thể.
        - Tạo `WebContent/addshift/edit_day.jsp` với biểu mẫu chi tiết ca làm việc (ngày, cửa hàng, nguyện vọng, giờ, ghi chú, nút lưu/xóa).
        - Cập nhật `WebContent/addshift/addshift.jsp` để các kỳ nộp lịch có thể nhấp vào và chuyển hướng đến `EnterShiftsAction`.
        - Cập nhật `WebContent/addshift/enter_shifts.jsp` để các ngày có thể nhấp vào và chuyển hướng đến `EditDayAction`.
    - **Chức năng Lưu chi tiết ca làm việc:**
        - Tạo `src/shift/SaveShiftDetailsAction.java` để xử lý việc lưu/cập nhật/xóa ca làm việc từ biểu mẫu `edit_day.jsp`.
        - Cập nhật `src/bean/ShiftBean.java` để thêm trường `memo`.
        - Cập nhật `src/dao/ShiftDAO.java` với các phương thức `deleteUserShift` và `saveOrUpdateUserShift`.
        - Cập nhật `WebContent/addshift/edit_day.jsp` để biểu mẫu trỏ đến `SaveShiftDetailsAction` và truyền các tham số cần thiết.
        - Cập nhật `src/shift/EnterShiftsAction.java` để lấy các ca làm việc đã lưu của người dùng và truyền đến `enter_shifts.jsp`
        - Cập nhật `WebContent/addshift/enter_shifts.jsp` để hiển thị thời gian đã lưu bên cạnh mỗi ngày.
    - **Sửa lỗi và Refactor:**
        - Sửa lỗi biên dịch `HttpSession` trong `src/shift/EnterShiftsAction.java`.
        - Sửa lỗi biên dịch `ShiftBean` và `DepartmentBean` trong `WebContent/addshift/enter_shifts.jsp`.
        - Sửa lỗi logic truyền tham số `startDate`/`endDate` từ `src/shift/EditDayAction.java` đến `WebContent/addshift/edit_day.jsp` và ngược lại.
        - Thêm mã debug vào `src/shift/EditDayAction.java` để chẩn đoán lỗi `勤務日null`.

- 2025-10-30: **UI Improvement for Admin Submitted Shifts Page:**
    - Created `WebContent/admin/css/submitted_shifts.css` to modularize styling.
    - Modified `WebContent/admin/submitted_shifts.jsp` to remove inline styles and link to the new external stylesheet, fixing text wrapping issues.

- 2025-10-30: **Fix: Department Name Display on User Homepage Calendar:**
    - Modified `src/dao/ShiftDAO.java` (`getShiftsByMonthAndStatus` method) to correctly `LEFT JOIN` the `department` table and fetch `dept_name`, resolving the "未設定" display issue.

- 2025-10-30: **Feature: Enhanced User Shift Submission & Re-submission Workflow ("Submit All"):**
    - **Database Schema Update:** Instructed user to run `ALTER TABLE shift MODIFY status ENUM('未提出','提出済み','確認済み','拒否','募集','下書き','承認済み') DEFAULT '未提出';` to add `下書き` (Draft) and `承認済み` (Approved) statuses.
    - **`src/shift/SaveShiftDetailsAction.java`:** Modified to save individual shift edits as `下書き` (Draft) instead of `提出済み`.
    - **`WebContent/addshift/enter_shifts.jsp`:** Replaced the "Complete Shift Submission" link with a new form and button to "Submit All Shifts for this Period".
    - **`src/shift/SubmitPeriodAction.java`:** Created a new servlet to handle the "Submit All" action. This action processes the entire period's shifts.
    - **`src/dao/ShiftDAO.java`:** Added `submitDraftsForPeriod` method (deletes old submissions, promotes drafts).
    - **`src/shift/EnterShiftsAction.java`:** Modified to call `revertSubmittedShiftsToDrafts` at the start of the `doGet` method. This ensures that when a user re-enters an already submitted period for editing, all previously `提出済み` shifts for that period are converted back to `下書き`, allowing for seamless re-submission without data loss.
    - **`src/dao/ShiftDAO.java`:** Added `revertSubmittedShiftsToDrafts` method to change `提出済み` shifts back to `下書き`.

- 2025-10-30: **Feature: Manager Approval & User Confirmation Workflow:**
    - **`src/admin/ApproveShiftAction.java`:** Modified to set shift status to `承認済み` (Approved by Manager) instead of `確認済み` when a manager approves a shift.
    - **`WebContent/shift/process_list.jsp`:** Created a new menu page for "処理一覧" (Process List), containing a link to "シフト確認" (Shift Confirmation).
    - **Navigation Links:** Updated "処理一覧" links in `WebContent/menu/menu.jsp`, `WebContent/mypage/my_page.jsp`, and `WebContent/password_change/password_change.jsp` to point to `process_list.jsp`.
    - **`src/shift/ListForConfirmationAction.java`:** Created a new servlet to fetch shifts with `承認済み` status for the logged-in user.
    - **`src/dao/ShiftDAO.java`:** Added `getShiftsByStatusForUser` method to fetch shifts by user and status.
    - **`WebContent/shift/shift_confirmation_list.jsp`:** Created a new JSP to display `承認済み` shifts in a table with checkboxes and a "Confirm" button.
    - **`src/shift/ConfirmShiftsAction.java`:** Created a new servlet to handle the confirmation of selected shifts.
    - **`src/dao/ShiftDAO.java`:** Added `updateStatusForMultipleShifts` method to update the status of multiple shifts to `確認済み` (Confirmed by User).

- 2025-10-30: **Improvement: Robustness for Admin "Add Urgent Shift" Functionality:**
    - Modified `src/dao/ShiftDAO.java` (`addOpenShift` method) to explicitly include `user_id` in the `INSERT` statement and set it to `NULL`, ensuring clarity and data integrity for open shifts.

- 2025-11-05: **Feature: Admin Shift Management & Correction:**
    - Renamed "シフト提出確認" to "シフト管理" in `admin_home.jsp`.
    - Created `WebContent/admin/shift_management_menu.jsp` with links for "シフト提出" and "シフト修正".
    - **Shift Correction ("シフト修正") Sub-feature:**
        - Implemented `src/admin/ListAllShiftsAction.java` to display all manageable shifts.
        - Added `ShiftDAO.getAllManageableShifts(Integer userId)` to filter shifts.
        - Created `WebContent/admin/shift_correction.jsp` to list shifts with delete option and add new shift form.
        - Implemented `src/admin/DeleteShiftAction.java` and `ShiftDAO.deleteShiftById(int shiftId)` for shift deletion.
        - Implemented `src/admin/AdminAddShiftAction.java` to prepare data for adding new shifts.
        - Added `UserDAO.getAllUsers()` to fetch all users for dropdowns.
        - Created `WebContent/admin/admin_add_shift.jsp` for admin to add new shifts.
        - Instructed user to add '修正依頼' status to `shift` table enum.
        - Implemented `src/admin/AdminAddShiftExecuteAction.java` and `ShiftDAO.addAdminInitiatedShift(ShiftBean shift)` to save admin-added shifts with '修正依頼' status.
        - Updated `src/shift/ListForConfirmationAction.java` to include '修正依頼' shifts for user confirmation.
    - **User Filter for Admin Shift Views:**
        - Added user filter dropdown to `WebContent/admin/shift_correction.jsp` and `WebContent/admin/submitted_shifts.jsp`.
        - Modified `src/admin/ListAllShiftsAction.java` and `src/admin/ListSubmittedShiftsAction.java` to handle user filtering.
        - Overloaded `ShiftDAO.getShiftsByStatus(String status, Integer userId)` to support user filtering.
    - **Bug Fixes & Refinements:**
        - Fixed missing imports/package declarations in `src/admin/ListAllShiftsAction.java` and `src/admin/ListSubmittedShiftsAction.java`.
        - Fixed "unreachable catch block" error in `src/admin/AddUrgentShiftAction.java` by reordering `catch` blocks.
        - Fixed JSP compilation error in `WebContent/admin/shift_correction.jsp` by correcting JSP directive placement and a stray character.
        - Improved error display in `WebContent/admin/shift_correction.jsp` by showing specific error messages.

- 2025-11-05: **Feature: User Emergency Shift Application (掲示板) Fixes:**
    - Refactored `src/shift_manager/ApplyShiftExecuteAction.java` to use the Post-Redirect-Get (PRG) pattern for robust form submission handling.
    - Updated `WebContent/shift_manager/open_shifts.jsp` to correctly display error/success messages passed via URL parameters.

- 2025-11-05: **Feature: Admin Reject Shift Functionality:**
    - Implemented `src/admin/RejectShiftAction.java` to handle rejecting submitted shifts.
    - Updated `WebContent/admin/submitted_shifts.jsp` to include a functional "拒否" (Reject) button with confirmation.