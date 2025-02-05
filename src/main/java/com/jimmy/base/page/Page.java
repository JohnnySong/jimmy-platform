package com.jimmy.base.page;

import java.util.List;

public class Page<T> {
    /** max record number in one page **/
    private int recordCountInPage = 10;

    /** max page index to show on page **/
    private int totalPageIndexCountToShow = 10;

    /** current page index **/
    private int currentPageIndex = 1;

    /** the first record' index that will be query from **/
    private int firstRecordQueryFrom = 0;

    /** pagination's start index **/
    private int pageIndexFrom = 1;

    /** pagination's finish index **/
    private int pageIndexTo = 1;

    /** total record number **/
    private int totalRecordCount = 0;

    /** total page number **/
    private int totalPageCount = 0;

    /** entities **/
    private List<T> entities;

    /** This is the pagination base url */
    private String baseUrl;

    public Page(String baseUrl) {
        this.baseUrl = baseUrl;
        setFirstRecordQueryFrom();
    }

    public Page(String baseUrl, int currentPageIndex) {
        this.baseUrl = baseUrl;
        this.currentPageIndex = currentPageIndex;
        setFirstRecordQueryFrom();
    }

    public Page(String baseUrl, int currentPageIndex, int recordCountInPage) {
        this.baseUrl = baseUrl;
        this.currentPageIndex = currentPageIndex;
        this.recordCountInPage = recordCountInPage;
        setFirstRecordQueryFrom();
    }

    /* getter and setter start */

    public int getTotalRecordCount() {
        return totalRecordCount;
    }

    public int getTotalPageCount() {
        int yushu = this.totalRecordCount % recordCountInPage;
        int chushu = this.totalRecordCount / recordCountInPage;
        this.totalPageCount = yushu == 0 ? chushu : chushu + 1;
        return this.totalPageCount;
    }

    public int getPageIndexFrom() {
        int half = totalPageIndexCountToShow / 2;
        if (currentPageIndex > half) {
            if (currentPageIndex + half < getTotalPageCount()) {
                pageIndexFrom = currentPageIndex - half;
            } else {
                pageIndexFrom = getTotalPageCount() - totalPageIndexCountToShow + 1;
            }
        }
        return pageIndexFrom;
    }

    public int getPageIndexTo() {

        int pageIndexFrom = getPageIndexFrom();
        int totalPageCount = getTotalPageCount();
        int desiredIndexTo = pageIndexFrom + totalPageIndexCountToShow - 1;

        if (totalPageCount >= desiredIndexTo) {
            pageIndexTo = desiredIndexTo;
        } else {
            pageIndexTo = totalPageCount;
        }

        return pageIndexTo;
    }

    public int getCurrentPageIndex() {
        return currentPageIndex;
    }

    public int getFirstRecordQueryFrom() {
        return firstRecordQueryFrom;
    }

    public int getRecordCountInPage() {
        return recordCountInPage;
    }

    public List<T> getEntities() {
        return entities;
    }

    public String getBaseUrl() {
        return baseUrl;
    }

    public void setTotalPageIndexCountToShow(int totalPageIndexCountToShow) {
        this.totalPageIndexCountToShow = totalPageIndexCountToShow;
    }

    public void setTotalRecordCount(int totalRecordCount) {
        this.totalRecordCount = totalRecordCount;
    }

    public void setCurrentPageIndex(int currentPageIndex) {
        this.currentPageIndex = currentPageIndex;
    }

    public void setPageIndexFrom(int pageIndexFrom) {
        this.pageIndexFrom = pageIndexFrom;
    }

    public void setPageIndexTo(int pageIndexTo) {
        this.pageIndexTo = pageIndexTo;
    }

    public void setFirstRecordQueryFrom() {
        this.firstRecordQueryFrom = (this.currentPageIndex - 1) * recordCountInPage;
    }

    public void setEntities(List<T> entities) {
        this.entities = entities;
    }

    public void setRecordCountInPage(int recordCountInPage) {
        this.recordCountInPage = recordCountInPage;
    }

    public void setBaseUrl(String baseUrl) {
        this.baseUrl = baseUrl;
    }

    /* getter and setter end */

}
