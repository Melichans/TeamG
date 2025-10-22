Project: Shift_AI

This file records the changes made by the Gemini AI assistant.

- 2025-10-21: Created this README.txt file to track project modifications.
- 2025-10-21: Modified `UserBean.java` to include `username` and `roleName` fields.
- 2025-10-21: Fixed database schema mismatch in `UserListServlet.java` and updated `users.jsp` to display correct user information.
- 2025-10-21: Removed broken links to `department_list.jsp` from `admin_home.jsp` and `developer_home.jsp`.
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
    - Removed recent notices display from `user_home.jsp` and the associated `src/home/HomeNoticeAction.java`.

- 2025-10-22: **Database Schema Update & Compatibility:**
    - Provided a comprehensive SQL script (`shift_ai_db.sql`) to update the database schema to support the integrated `TeamGShift` functionality (including `role` table, modifications to `account`, `company`, `user`, `shift` tables).
    - Assisted with debugging database schema issues and provided `INSERT` statements for `company` data.
    - Updated `src/loginlogout/LoginExecuteAction.java` to correctly use `roleId` from `AccountBean` and fetch `roleName` from the `role` table.

- 2025-10-22: **Shift List Page Layout:**
    - Applied a modern and consistent layout to `WebContent/shift_manager/open_shifts.jsp`.