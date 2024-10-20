
-- 24f - CS 3200 - Introduction to Databases - Homework 03

-- Put your name here: Ivan Ng

CREATE DATABASE BlogDB;

USE BlogDB;

CREATE TABLE users (
    firstName varchar(50),
    middleName varchar(50),
    lastName varchar(50),
    username varchar(30) UNIQUE,
    mobile varchar(15) UNIQUE,
    email varchar (75) UNIQUE,
    passwordHash varchar(128) NOT NULL,
    registeredAt datetime NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    lastLogin datetime,
    updatedAt datetime
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    intro tinytext,
    profile text,
    active boolean
        DEFAULT true,
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    INDEX idx_mobile (mobile),
    INDEX idx_email (email),
    INDEX idx_id (id)
);

CREATE TABLE posts (
    authorId int NOT NULL,
    title varchar(75) NOT NULL,
    metaTitle varchar(100),
    slug varchar(100) NOT NULL UNIQUE,
    summary tinytext,
    published tinyint(1) NOT NULL,
    createdAt datetime NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    updatedAt datetime
        DEFAULT CURRENT_TIMESTAMP,
    content text,
    aiSummary text,
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    INDEX idx_authorId (authorId),
    INDEX idx_slug (slug),
    INDEX idx_id (id),
    CONSTRAINT posts_authorId_to_id FOREIGN KEY (authorId)
        REFERENCES users (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE tags (
    title varchar(75) NOT NULL,
    metaTitle varchar(100),
    slug varchar (100) NOT NULL,
    content text,
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    INDEX idx_id (id)
);

CREATE TABLE categories (
    title varchar(75) NOT NULL,
    metaTitle varchar(100),
    slug varchar(100) NOT NULL,
    content text,
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    INDEX idx_id (id)
);

CREATE TABLE post_tags (
    postId int NOT NULL,
    tagId int NOT NULL,
    PRIMARY KEY (postId, tagId),
    INDEX idx_postId (postId),
    INDEX idx_tagId (tagId),
    CONSTRAINT post_tags_postId_to_id FOREIGN KEY (postId)
        REFERENCES posts (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT post_tags_tagId_to_id FOREIGN KEY (tagId)
        REFERENCES tags (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE post_comments (
    postId int NOT NULL,
    title varchar(100) NOT NULL,
    published tinyint(1) NOT NULL,
    createdAt datetime NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    publishedAt datetime,
    content text,
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    INDEX idx_postId (postId),
    INDEX idx_id (id),
    CONSTRAINT post_comments_postId_to_id FOREIGN KEY (postId)
        REFERENCES posts (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE post_categories (
    postId int NOT NULL,
    categoryId int NOT NULL,
    PRIMARY KEY (postId, categoryId),
    INDEX idx_postId (postId),
    INDEX idx_categoryId (categoryId),
    CONSTRAINT post_categories_postId_to_id FOREIGN KEY (postId)
        REFERENCES posts (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT post_categories_categoryId_to_id FOREIGN KEY (categoryId)
        REFERENCES categories (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO users (firstName, lastName, username, passwordHash, email)
VALUES
    ('Ivan', 'Ng', 'Johanathon2k', 'Password123', 'johan@gmail.com'),
    ('Sam', 'Ehlers', 'Ellerman', 'Password123', 'eller@gmail.com'),
    ('Jason', 'Matiteeb', 'Sock2', 'Password123', 'jason@gmail.com'),
    ('Brant', 'Pan', 'ningningbao', 'Password123', 'brant@gmail.com');

INSERT INTO tags (title, slug)
VALUES
    ('Keshi', 'keshi_always'),
    ('Lebron', 'lebron_stats');

INSERT INTO categories (title, slug)
VALUES
    ('Technology', 'techno'),
    ('Music', 'music');

INSERT INTO posts (authorId, title, slug, published)
VALUES
    (1, 'Evolution','cdarwin_birds', 1),
    (2, 'Elements', 'greek_science', 1),
    (3, 'Nuclear', 'split_molecule', 1),
    (4, 'PlayBook', 'the_book', 1),
    (4, 'Architect', 'gnb_hq', 1),
    (3, 'Potter', 'harry_potter', 1);

INSERT INTO post_tags (postId, tagId)
VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 2),
    (3, 1),
    (3, 2),
    (4, 1),
    (4, 2),
    (5, 1),
    (5, 2),
    (6, 1),
    (6, 2);

INSERT INTO post_categories (postId, categoryId)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 1),
    (5, 2),
    (6, 2);

INSERT INTO post_comments (postId, title, published, publishedAt, content)
VALUES
    (1, 'PZEZ', 1, NOW(), 'EZ 4 ENCE'),
    (1, 'Katka', 1, NOW(), 'Niko Ace'),
    (3, 'Bomba', 1, NOW(), 'Sloppy Walrus'),
    (3, 'C4', 1, NOW(), 'T-Side Wins'),
    (5, 'Building', 1, NOW(), 'Roman column'),
    (5, 'Bridges', 1, NOW(), 'Arches');