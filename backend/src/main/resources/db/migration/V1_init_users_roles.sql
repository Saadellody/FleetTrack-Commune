-- ---------------------------------------------------------------------
-- Table : users
-- ---------------------------------------------------------------------

CREATE TABLE users (
                       id              BIGSERIAL PRIMARY KEY,
                       username        VARCHAR(50)  NOT NULL,
                       password_hash   VARCHAR(255) NOT NULL,
                       full_name       VARCHAR(150) NOT NULL,
                       email           VARCHAR(150),
                       role            VARCHAR(30)  NOT NULL,
                       active          BOOLEAN      NOT NULL DEFAULT true,
                       created_at      TIMESTAMP    NOT NULL DEFAULT now(),
                       updated_at      TIMESTAMP,

                       CONSTRAINT uq_users_username UNIQUE (username),
                       CONSTRAINT uq_users_email UNIQUE (email),
                       CONSTRAINT chk_users_role CHECK (role IN (
                                                                 'ADMIN', 'CHEF_PARC', 'RESPONSABLE_VEHICULE', 'VERIFICATEUR', 'CONSULTATION'
                           ))
);