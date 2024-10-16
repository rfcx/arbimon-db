create table arbimon2.pattern_matching_rois_new (
    pattern_matching_roi_id   int unsigned auto_increment,
    pattern_matching_id       int not null references arbimon2.pattern_matchings (pattern_matching_id),
    recording_id              bigint unsigned not null references arbimon2.recordings (recording_id) on delete cascade,
    species_id                int not null references arbimon2.species (species_id),
    songtype_id               int not null references arbimon2.songtypes (songtype_id),
    x1                        float not null,
    y1                        mediumint unsigned not null,
    x2                        float not null,
    y2                        mediumint unsigned not null,
    uri_param1                int unsigned not null,
    uri_param2                smallint unsigned null,
    score                     float null,
    validated                 tinyint(1) null,
    cs_val_present            tinyint default 0 not null,
    cs_val_not_present        tinyint default 0 not null,
    consensus_validated       tinyint(1) null,
    expert_validated          tinyint(1) null,
    expert_validation_user_id smallint unsigned null,
    denorm_site_id            int unsigned null references arbimon2.sites (site_id),
    denorm_recording_datetime datetime null,
    denorm_recording_date     date null,
    PRIMARY KEY (pattern_matching_roi_id, pattern_matching_id),
    KEY `pattern_matching_matches_site_score_idx` (`denorm_site_id`,`score`),
    KEY `pattern_matching_matches_site_datetime_score_idx` (`denorm_site_id`,`denorm_recording_date`,`score`),
    KEY `validated_idx` (`validated`),
    KEY `pattern_matching_id_idx` (`pattern_matching_id`)
) PARTITION BY HASH(pattern_matching_id) PARTITIONS 100;