﻿CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20241023095517_V0', '8.0.10');

START TRANSACTION;

CREATE TABLE address (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    detailed_address text NOT NULL,
    district character varying(100),
    city character varying(100),
    country character varying(100),
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT address_pkey PRIMARY KEY (id)
);

CREATE TABLE category (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    name character varying(255) NOT NULL,
    image character varying(255),
    product_count integer,
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT category_pkey PRIMARY KEY (id)
);

CREATE TABLE color (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    color_name character varying(50) NOT NULL,
    CONSTRAINT color_pkey PRIMARY KEY (id)
);

CREATE TABLE coupon (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    code character varying(50) NOT NULL,
    discount_value numeric(10,2) NOT NULL,
    minimum_spend numeric(10,2),
    usage_count integer DEFAULT 0,
    usage_limit integer,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT coupon_pkey PRIMARY KEY (id)
);

CREATE TABLE order_status (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    status character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT order_status_pkey PRIMARY KEY (id)
);

CREATE TABLE product_size (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    size_name character varying(50) NOT NULL,
    CONSTRAINT product_size_pkey PRIMARY KEY (id)
);

CREATE TABLE shipping_method (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    name character varying(100) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT shipping_method_pkey PRIMARY KEY (id)
);

CREATE TABLE shop_user (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    phone_number character varying(20),
    email character varying(255),
    password character varying(255) NOT NULL,
    username character varying(50),
    birthday date,
    avatar character varying(255),
    is_active boolean DEFAULT TRUE,
    role character varying(20),
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT shop_user_pkey PRIMARY KEY (id)
);

CREATE TABLE product (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    name character varying(255) NOT NULL,
    product_description text,
    delivery_description text,
    parent_category_id integer,
    rating_average numeric(3,2),
    rating_count integer,
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    deleted_at timestamp without time zone,
    CONSTRAINT product_pkey PRIMARY KEY (id),
    CONSTRAINT product_parent_category_id_fkey FOREIGN KEY (parent_category_id) REFERENCES category (id)
);

CREATE TABLE cart (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT cart_pkey PRIMARY KEY (id),
    CONSTRAINT cart_user_id_fkey FOREIGN KEY (user_id) REFERENCES shop_user (id)
);

CREATE TABLE shop_order (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    user_id integer NOT NULL,
    order_date timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    status_id integer NOT NULL,
    payment_method character varying(50),
    coupon_id integer,
    shipping_method_id integer NOT NULL,
    total_quantity integer NOT NULL,
    total_price numeric(10,2) NOT NULL,
    note text,
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT shop_order_pkey PRIMARY KEY (id),
    CONSTRAINT shop_order_coupon_id_fkey FOREIGN KEY (coupon_id) REFERENCES coupon (id),
    CONSTRAINT shop_order_shipping_method_id_fkey FOREIGN KEY (shipping_method_id) REFERENCES shipping_method (id),
    CONSTRAINT shop_order_status_id_fkey FOREIGN KEY (status_id) REFERENCES order_status (id),
    CONSTRAINT shop_order_user_id_fkey FOREIGN KEY (user_id) REFERENCES shop_user (id)
);

CREATE TABLE user_address (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    user_id integer NOT NULL,
    address_id integer NOT NULL,
    is_default boolean DEFAULT FALSE,
    customer_name character varying(255),
    phone_number character varying(20),
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT user_address_pkey PRIMARY KEY (id),
    CONSTRAINT user_address_address_id_fkey FOREIGN KEY (address_id) REFERENCES address (id),
    CONSTRAINT user_address_user_id_fkey FOREIGN KEY (user_id) REFERENCES shop_user (id)
);

CREATE TABLE product_category (
    category_id integer NOT NULL,
    product_id integer NOT NULL,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id, product_id),
    CONSTRAINT product_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES category (id),
    CONSTRAINT product_category_product_id_fkey FOREIGN KEY (product_id) REFERENCES product (id)
);

CREATE TABLE product_item (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    product_id integer NOT NULL,
    color_id integer,
    size_id integer,
    original_price numeric(10,2) NOT NULL,
    sale_price numeric(10,2),
    quantity_in_stock integer NOT NULL,
    CONSTRAINT product_item_pkey PRIMARY KEY (id),
    CONSTRAINT product_item_color_id_fkey FOREIGN KEY (color_id) REFERENCES color (id),
    CONSTRAINT product_item_product_id_fkey FOREIGN KEY (product_id) REFERENCES product (id),
    CONSTRAINT product_item_size_id_fkey FOREIGN KEY (size_id) REFERENCES product_size (id)
);

CREATE TABLE review (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    comments text,
    rating integer,
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT review_pkey PRIMARY KEY (id),
    CONSTRAINT review_product_id_fkey FOREIGN KEY (product_id) REFERENCES product (id),
    CONSTRAINT review_user_id_fkey FOREIGN KEY (user_id) REFERENCES shop_user (id)
);

CREATE TABLE wishlist (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT wishlist_product_id_fkey FOREIGN KEY (product_id) REFERENCES product (id),
    CONSTRAINT wishlist_user_id_fkey FOREIGN KEY (user_id) REFERENCES shop_user (id)
);

CREATE TABLE cart_item (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT cart_item_pkey PRIMARY KEY (id),
    CONSTRAINT cart_item_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES cart (id),
    CONSTRAINT cart_item_product_id_fkey FOREIGN KEY (product_id) REFERENCES product (id)
);

CREATE TABLE order_item (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    product_id integer NOT NULL,
    order_id integer NOT NULL,
    price numeric(10,2) NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    updated_at timestamp without time zone DEFAULT (CURRENT_TIMESTAMP),
    CONSTRAINT order_item_pkey PRIMARY KEY (id),
    CONSTRAINT order_item_order_id_fkey FOREIGN KEY (order_id) REFERENCES shop_order (id),
    CONSTRAINT order_item_product_id_fkey FOREIGN KEY (product_id) REFERENCES product (id)
);

CREATE TABLE product_image (
    id integer GENERATED BY DEFAULT AS IDENTITY,
    product_item_id integer NOT NULL,
    image_url character varying(255) NOT NULL,
    CONSTRAINT product_image_pkey PRIMARY KEY (id),
    CONSTRAINT product_image_product_item_id_fkey FOREIGN KEY (product_item_id) REFERENCES product_item (id)
);

CREATE INDEX "IX_cart_user_id" ON cart (user_id);

CREATE INDEX "IX_cart_item_cart_id" ON cart_item (cart_id);

CREATE INDEX "IX_cart_item_product_id" ON cart_item (product_id);

CREATE UNIQUE INDEX coupon_code_key ON coupon (code);

CREATE INDEX "IX_order_item_order_id" ON order_item (order_id);

CREATE INDEX "IX_order_item_product_id" ON order_item (product_id);

CREATE INDEX "IX_product_parent_category_id" ON product (parent_category_id);

CREATE INDEX "IX_product_category_product_id" ON product_category (product_id);

CREATE INDEX "IX_product_image_product_item_id" ON product_image (product_item_id);

CREATE INDEX "IX_product_item_color_id" ON product_item (color_id);

CREATE INDEX "IX_product_item_product_id" ON product_item (product_id);

CREATE INDEX "IX_product_item_size_id" ON product_item (size_id);

CREATE INDEX "IX_review_product_id" ON review (product_id);

CREATE INDEX "IX_review_user_id" ON review (user_id);

CREATE INDEX "IX_shop_order_coupon_id" ON shop_order (coupon_id);

CREATE INDEX "IX_shop_order_shipping_method_id" ON shop_order (shipping_method_id);

CREATE INDEX "IX_shop_order_status_id" ON shop_order (status_id);

CREATE INDEX "IX_shop_order_user_id" ON shop_order (user_id);

CREATE UNIQUE INDEX shop_user_email_key ON shop_user (email);

CREATE UNIQUE INDEX shop_user_phone_number_key ON shop_user (phone_number);

CREATE UNIQUE INDEX shop_user_username_key ON shop_user (username);

CREATE INDEX "IX_user_address_address_id" ON user_address (address_id);

CREATE INDEX "IX_user_address_user_id" ON user_address (user_id);

CREATE INDEX "IX_wishlist_product_id" ON wishlist (product_id);

CREATE INDEX "IX_wishlist_user_id" ON wishlist (user_id);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20241023095517_V0', '8.0.10');

COMMIT;

