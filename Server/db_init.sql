create table detections
(
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    species    TEXT    NOT NULL,
    confidence REAL    NOT NULL,
    start_time INTEGER NOT NULL,
    end_time   INTEGER NOT NULL,
    dev_eui    TEXT    NOT NULL,
    CONSTRAINT detection_device_rel FOREIGN KEY (dev_eui) REFERENCES devices (dev_eui)
);

create table devices
(
    dev_eui   TEXT    NOT NULL PRIMARY KEY,
    owner     INTEGER NOT NULL,
    name TEXT NOT NULL,
    latitude  REAL    NOT NULL,
    longitude REAL    NOT NULL,
    CONSTRAINT device_owner_rel FOREIGN KEY (owner) REFERENCES users (user_id)
);

create table users
(
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name    TEXT NOT NULL
);

create table articles(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    publish_time INTEGER NOT NULL,
    header TEXT NOT NULL,
    article_url TEXT NOT NULL,
    img_url TEXT NOT NULL
)