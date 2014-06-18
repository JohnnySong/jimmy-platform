package com.jimmy.service.impl;

import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import com.jimmy.base.db.DaoSupport;
import com.jimmy.module.common.Tag;
import com.jimmy.service.TagService;
import com.jimmy.util.Constant;

@Service
@Transactional(readOnly = false)
public class TagServiceImpl extends DaoSupport<Tag> implements TagService {
    
    public Set<Tag> getAllTags(Tag tag) {
        Set<Tag> allTags = getAllSubTags(tag);
        allTags.add(tag);
        return allTags;
    }
    
    public Set<Tag> getAllSubTags(Tag tag) {
        Set<Tag> childTags = new HashSet<Tag>();
        return getAllSubTags(childTags, tag);
    }
    
    public List<Tag> getFirstLevelTags() {
        
        LinkedHashMap<String, String> orderMap = new LinkedHashMap<String, String>();
        orderMap.put("name", Constant.ORDER_ASC);
        String queryString = "from Tag o where o.level = 1";
        return findAll(queryString);
    }
    
    private Set<Tag> getAllSubTags(Set<Tag> allTags, Tag tag) {
        
        List<Tag> childTags = tag.getChildren();
        
        if (!CollectionUtils.isEmpty(childTags)) {
            allTags.addAll(tag.getChildren());
            
            for (Tag tag2 : childTags) {
                getAllSubTags(allTags, tag2);
            }
        }
        
        return allTags;
    }
}
