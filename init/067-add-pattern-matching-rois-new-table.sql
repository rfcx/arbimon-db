create table arbimon2.pattern_matching_rois_new (
    pattern_matching_roi_id   int unsigned auto_increment primary key,
    pattern_matching_id       int not null,
    recording_id              bigint unsigned not null,
    species_id                int not null,
    songtype_id               int not null,
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
    denorm_site_id            int unsigned null,
    denorm_recording_datetime datetime null,
    denorm_recording_date     date null,
    KEY `fk_pattern_matching_matches_1_idx` (`pattern_matching_id`),
    KEY `fk_pattern_matching_matches_2_idx` (`recording_id`),
    KEY `fk_pattern_matching_matches_3_idx` (`species_id`),
    KEY `fk_pattern_matching_matches_4_idx` (`songtype_id`),
    KEY `fk_pattern_matching_rois_1_idx` (`denorm_site_id`),
    KEY `pattern_matching_matches_recording_score_idx` (`recording_id`,`score`),
    KEY `pattern_matching_matches_site_score_idx` (`pattern_matching_id`,`denorm_site_id`,`score`),
    KEY `pattern_matching_matches_site_datetime_score_idx` (`pattern_matching_id`,`denorm_site_id`,`denorm_recording_date`,`score`),
    KEY `validated_idx` (`validated`),
    constraint fk_pattern_matching_rois_2
        foreign key (pattern_matching_id) references arbimon2.pattern_matchings (pattern_matching_id),
    constraint fk_pattern_matching_rois_3
        foreign key (recording_id) references arbimon2.recordings (recording_id) on delete cascade,
    constraint fk_pattern_matching_rois_4
        foreign key (species_id) references arbimon2.species (species_id),
    constraint fk_pattern_matching_rois_5
        foreign key (songtype_id) references arbimon2.songtypes (songtype_id),
    constraint fk_pattern_matching_rois_6
        foreign key (denorm_site_id) references arbimon2.sites (site_id)
);
