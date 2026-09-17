-- ============================================================
-- Schéma PostgreSQL — Plateforme de cours (MVP)
-- 7 tables : users, parent_student, courses, course_sessions,
--            enrollment_requests, attendance_records, progress_records
-- ============================================================

CREATE TABLE users (
    id              BIGSERIAL PRIMARY KEY,
    email           VARCHAR(255) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    role            VARCHAR(20)  NOT NULL
                    CHECK (role IN ('student', 'parent', 'teacher', 'staff')),
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    birth_date      DATE,
    is_active       BOOLEAN      NOT NULL DEFAULT TRUE,
    last_login      TIMESTAMPTZ,
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_users_role ON users(role);

CREATE TABLE parent_student (
    parent_id   BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    student_id  BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY (parent_id, student_id),
    CHECK (parent_id <> student_id)
);

CREATE INDEX idx_parent_student_student ON parent_student(student_id);

CREATE TABLE courses (
    id           BIGSERIAL PRIMARY KEY,
    teacher_id   BIGINT NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    title        VARCHAR(150) NOT NULL,
    subject      VARCHAR(100) NOT NULL,
    day_of_week  SMALLINT     NOT NULL CHECK (day_of_week BETWEEN 0 AND 6),
    start_time   TIME         NOT NULL,
    end_time     TIME         NOT NULL,
    zoom_link    VARCHAR(500),
    CHECK (end_time > start_time)
);

CREATE INDEX idx_courses_teacher ON courses(teacher_id);
CREATE INDEX idx_courses_subject ON courses(subject);

CREATE TABLE course_sessions (
    id          BIGSERIAL PRIMARY KEY,
    course_id   BIGINT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    date        TIMESTAMPTZ NOT NULL,
    zoom_link   VARCHAR(500)
);

CREATE INDEX idx_course_sessions_course ON course_sessions(course_id);
CREATE INDEX idx_course_sessions_date   ON course_sessions(date);

CREATE TABLE enrollment_requests (
    id              BIGSERIAL PRIMARY KEY,
    student_id      BIGINT NOT NULL REFERENCES users(id)   ON DELETE CASCADE,
    course_id       BIGINT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    requested_by_id BIGINT NOT NULL REFERENCES users(id)   ON DELETE RESTRICT,
    status          VARCHAR(20) NOT NULL DEFAULT 'pending'
                    CHECK (status IN ('pending', 'approved', 'rejected')),
    handled_by_id   BIGINT REFERENCES users(id) ON DELETE SET NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_enrollment_status  ON enrollment_requests(status);
CREATE INDEX idx_enrollment_student ON enrollment_requests(student_id);
CREATE INDEX idx_enrollment_course  ON enrollment_requests(course_id);

CREATE TABLE attendance_records (
    id          BIGSERIAL PRIMARY KEY,
    session_id  BIGINT NOT NULL REFERENCES course_sessions(id) ON DELETE CASCADE,
    student_id  BIGINT NOT NULL REFERENCES users(id)           ON DELETE CASCADE,
    status      VARCHAR(20) NOT NULL
                CHECK (status IN ('present', 'absent', 'late')),
    note        TEXT,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (session_id, student_id)
);

CREATE INDEX idx_attendance_student ON attendance_records(student_id);
CREATE INDEX idx_attendance_session ON attendance_records(session_id);

CREATE TABLE progress_records (
    id          BIGSERIAL PRIMARY KEY,
    student_id  BIGINT NOT NULL REFERENCES users(id)   ON DELETE CASCADE,
    course_id   BIGINT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    teacher_id  BIGINT NOT NULL REFERENCES users(id)   ON DELETE RESTRICT,
    level       VARCHAR(50) NOT NULL,
    note        TEXT,
    date        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_progress_student ON progress_records(student_id);
CREATE INDEX idx_progress_course  ON progress_records(course_id);
CREATE INDEX idx_progress_teacher ON progress_records(teacher_id);