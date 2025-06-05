CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE CHECK(length(name) >= 2),
    description TEXT DEFAULT 'Категория комплектующих ПК'
);

CREATE TABLE spec_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    unit VARCHAR(20),
    data_type TEXT NOT NULL CHECK(data_type IN ('int', 'float', 'string', 'bool')) -- индексация лучше
);

CREATE TABLE components (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL CHECK(length(name) >= 2),
    category_id INTEGER NOT NULL,
    description TEXT,
    price DECIMAL(10,2) CHECK(price >= 0),
    release_year INTEGER CHECK(release_year >= 2000),
    manufacturer VARCHAR(50) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

CREATE TABLE builds (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE CHECK(length(name) >= 3),
    total_price DECIMAL(10,2) CHECK(total_price >= 0),
    power_usage INTEGER CHECK(power_usage > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE specifications (
    component_id INTEGER NOT NULL,
    spec_type_id INTEGER NOT NULL,
    value VARCHAR(100) NOT NULL,
    PRIMARY KEY (component_id, spec_type_id),
    FOREIGN KEY (component_id) REFERENCES components(id) ON DELETE CASCADE,
    FOREIGN KEY (spec_type_id) REFERENCES spec_types(id) ON DELETE CASCADE
);

CREATE TABLE build_items (
    build_id INTEGER NOT NULL,
    component_id INTEGER NOT NULL,
    quantity INTEGER DEFAULT 1 CHECK(quantity BETWEEN 1 AND 10),
    PRIMARY KEY (build_id, component_id),
    FOREIGN KEY (build_id) REFERENCES builds(id) ON DELETE CASCADE,
    FOREIGN KEY (component_id) REFERENCES components(id) ON DELETE CASCADE
);

CREATE TABLE compatibilities (
    source_id INTEGER NOT NULL,
    target_id INTEGER NOT NULL,
    rule_type TEXT NOT NULL CHECK(rule_type IN ('socket', 'format', 'power', 'memory', 'interface')),
    source_spec INTEGER NOT NULL,
    target_spec INTEGER NOT NULL,
    PRIMARY KEY (source_id, target_id, rule_type),
    FOREIGN KEY (source_id) REFERENCES components(id) ON DELETE CASCADE,
    FOREIGN KEY (target_id) REFERENCES components(id) ON DELETE CASCADE,
    FOREIGN KEY (source_spec) REFERENCES spec_types(id),
    FOREIGN KEY (target_spec) REFERENCES spec_types(id)
);

-- Создание индексов
CREATE INDEX idx_components_manufacturer ON components(manufacturer, release_year);
CREATE UNIQUE INDEX idx_spec_types_unique_name_unit ON spec_types(name, unit) WHERE unit IS NOT NULL;