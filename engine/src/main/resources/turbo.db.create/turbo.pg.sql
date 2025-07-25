CREATE TABLE em_flow_definition (
    id bigserial NOT NULL,
    flow_module_id varchar(128) NOT NULL DEFAULT '',
    flow_name varchar(64) NOT NULL DEFAULT '',
    flow_key varchar(32) NOT NULL DEFAULT '',
    tenant_id varchar(16) NOT NULL DEFAULT '',
    flow_model text,
    status smallint NOT NULL DEFAULT '0',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modify_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    operator varchar(32) NOT NULL DEFAULT '',
    remark varchar(512) NOT NULL DEFAULT '',
    archive smallint NOT NULL DEFAULT '0',
    tenant varchar(100) NOT NULL DEFAULT '',
    caller varchar(100) NOT NULL DEFAULT '',
    PRIMARY KEY (id),
    constraint uniq_flow_module_id unique(flow_module_id)
);

COMMENT ON COLUMN "em_flow_definition"."id" IS '自增主键';
COMMENT ON COLUMN "em_flow_definition"."flow_module_id" IS '流程模型id';
COMMENT ON COLUMN "em_flow_definition"."flow_name" IS '流程名称';
COMMENT ON COLUMN "em_flow_definition"."flow_key" IS '流程业务标识';
COMMENT ON COLUMN "em_flow_definition"."tenant_id" IS '业务方标识';
COMMENT ON COLUMN "em_flow_definition"."flow_model" IS '表单定义';
COMMENT ON COLUMN "em_flow_definition"."status" IS '状态(1.初始态 2.编辑中 3.已下线)';
COMMENT ON COLUMN "em_flow_definition"."create_time" IS '流程创建时间';
COMMENT ON COLUMN "em_flow_definition"."modify_time" IS '流程修改时间';
COMMENT ON COLUMN "em_flow_definition"."operator" IS '操作人';
COMMENT ON COLUMN "em_flow_definition"."remark" IS '备注';
COMMENT ON COLUMN "em_flow_definition"."archive" IS '归档状态(0未删除，1删除)';
COMMENT ON COLUMN "em_flow_definition"."tenant" IS '租户';
COMMENT ON COLUMN "em_flow_definition"."caller" IS '调用方';
COMMENT ON TABLE "em_flow_definition" IS '流程定义表';

CREATE TABLE em_flow_deployment (
    id bigserial NOT NULL,
    flow_deploy_id varchar(128) NOT NULL DEFAULT '',
    flow_module_id varchar(128) NOT NULL DEFAULT '',
    flow_name varchar(64) NOT NULL DEFAULT '',
    flow_key varchar(32) NOT NULL DEFAULT '',
    tenant_id varchar(16) NOT NULL DEFAULT '',
    flow_model text,
    status smallint NOT NULL DEFAULT '0',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modify_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    operator varchar(32) NOT NULL DEFAULT '',
    remark varchar(512) NOT NULL DEFAULT '',
    archive smallint NOT NULL DEFAULT '0',
    tenant varchar(100) NOT NULL DEFAULT '',
    caller varchar(100) NOT NULL DEFAULT '',
    PRIMARY KEY (id),
    constraint uniq_flow_deploy_id unique(flow_deploy_id)
);

CREATE INDEX idx_flow_module_id ON em_flow_deployment (flow_module_id);

COMMENT ON COLUMN "em_flow_deployment"."id" IS '自增主键';
COMMENT ON COLUMN "em_flow_deployment"."flow_deploy_id" IS '流程模型部署id';
COMMENT ON COLUMN "em_flow_deployment"."flow_module_id" IS '流程模型id';
COMMENT ON COLUMN "em_flow_deployment"."flow_name" IS '流程名称';
COMMENT ON COLUMN "em_flow_deployment"."flow_key" IS '流程业务标识';
COMMENT ON COLUMN "em_flow_deployment"."tenant_id" IS '业务方标识';
COMMENT ON COLUMN "em_flow_deployment"."flow_model" IS '表单定义';
COMMENT ON COLUMN "em_flow_deployment"."status" IS '状态(1.已部署 3.已下线)';
COMMENT ON COLUMN "em_flow_deployment"."create_time" IS '流程创建时间';
COMMENT ON COLUMN "em_flow_deployment"."modify_time" IS '流程修改时间';
COMMENT ON COLUMN "em_flow_deployment"."operator" IS '操作人';
COMMENT ON COLUMN "em_flow_deployment"."remark" IS '备注';
COMMENT ON COLUMN "em_flow_deployment"."archive" IS '归档状态(0未删除，1删除)';
COMMENT ON COLUMN "em_flow_deployment"."tenant" IS '租户';
COMMENT ON COLUMN "em_flow_deployment"."caller" IS '调用方';
COMMENT ON TABLE "em_flow_deployment" IS '流程部署表';

CREATE TABLE ei_flow_instance (
    id bigserial NOT NULL,
    flow_instance_id varchar(128) NOT NULL DEFAULT '',
    parent_flow_instance_id varchar(128) NOT NULL DEFAULT '',
    flow_deploy_id varchar(128) NOT NULL DEFAULT '',
    flow_module_id varchar(128) NOT NULL DEFAULT '',
    tenant_id varchar(16) NOT NULL DEFAULT '',
    status smallint NOT NULL DEFAULT '0',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modify_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    archive smallint NOT NULL DEFAULT '0',
    tenant varchar(100) NOT NULL DEFAULT '',
    caller varchar(100) NOT NULL DEFAULT '',
    PRIMARY KEY (id),
    constraint uniq_flow_instance_id unique(flow_instance_id)
);

COMMENT ON COLUMN "ei_flow_instance"."id" IS '自增主键';
COMMENT ON COLUMN "ei_flow_instance"."flow_instance_id" IS '流程执行实例id';
COMMENT ON COLUMN "ei_flow_instance"."parent_flow_instance_id" IS '父流程执行实例id';
COMMENT ON COLUMN "ei_flow_instance"."flow_deploy_id" IS '流程模型部署id';
COMMENT ON COLUMN "ei_flow_instance"."flow_module_id" IS '流程模型id';
COMMENT ON COLUMN "ei_flow_instance"."tenant_id" IS '业务方标识';
COMMENT ON COLUMN "ei_flow_instance"."status" IS '状态(1.执行完成 2.执行中 3.执行终止(强制终止))';
COMMENT ON COLUMN "ei_flow_instance"."create_time" IS '流程创建时间';
COMMENT ON COLUMN "ei_flow_instance"."modify_time" IS '流程修改时间';
COMMENT ON COLUMN "ei_flow_instance"."archive" IS '归档状态(0未删除，1删除)';
COMMENT ON COLUMN "ei_flow_instance"."tenant" IS '租户';
COMMENT ON COLUMN "ei_flow_instance"."caller" IS '调用方';
COMMENT ON TABLE "ei_flow_instance" IS '流程执行实例表';

CREATE TABLE ei_flow_instance_mapping (
    id bigserial NOT NULL,
    flow_instance_id varchar(128) NOT NULL DEFAULT '',
    node_instance_id varchar(128) NOT NULL DEFAULT '',
    node_key varchar(64) NOT NULL DEFAULT '',
    sub_flow_instance_id varchar(128) NOT NULL DEFAULT '',
    type smallint NOT NULL DEFAULT '0',
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modify_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    archive smallint NOT NULL DEFAULT '0',
    tenant varchar(100) NOT NULL DEFAULT '',
    caller varchar(100) NOT NULL DEFAULT '',
    PRIMARY KEY (id)
);

CREATE INDEX idx_fii ON ei_flow_instance_mapping (flow_instance_id);

COMMENT ON COLUMN "ei_flow_instance_mapping"."id" IS '自增主键';
COMMENT ON COLUMN "ei_flow_instance_mapping"."flow_instance_id" IS '流程执行实例id';
COMMENT ON COLUMN "ei_flow_instance_mapping"."node_instance_id" IS '节点执行实例id';
COMMENT ON COLUMN "ei_flow_instance_mapping"."node_key" IS '节点唯一标识';
COMMENT ON COLUMN "ei_flow_instance_mapping"."sub_flow_instance_id" IS '子流程执行实例id';
COMMENT ON COLUMN "ei_flow_instance_mapping"."type" IS '状态(1.执行 2.回滚)';
COMMENT ON COLUMN "ei_flow_instance_mapping"."create_time" IS '流程创建时间';
COMMENT ON COLUMN "ei_flow_instance_mapping"."modify_time" IS '流程修改时间';
COMMENT ON COLUMN "ei_flow_instance_mapping"."archive" IS '归档状态(0未删除，1删除)';
COMMENT ON COLUMN "ei_flow_instance_mapping"."tenant" IS '租户';
COMMENT ON COLUMN "ei_flow_instance_mapping"."caller" IS '调用方';
COMMENT ON TABLE "ei_flow_instance_mapping" IS '父子流程实例映射表';