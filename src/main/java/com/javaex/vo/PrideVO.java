package com.javaex.vo;

public class PrideVO {

    // 필드
    private Long id;               
    private String title;           
    private String tagsCsv;         
    private String tags;            
    private String instagramHandle; 
    private String content;         

    // 생성자
    public PrideVO() {
    	
    }
    public PrideVO(Long id, String title, String tagsCsv, String tags, String instagramHandle, String content) {
        this.id = id;
        this.title = title;
        this.tagsCsv = tagsCsv;
        this.tags = tags;
        this.instagramHandle = instagramHandle;
        this.content = content;
    }

    // getter/setter
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getTagsCsv() { return tagsCsv; }
    public void setTagsCsv(String tagsCsv) { this.tagsCsv = tagsCsv; }

    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }

    public String getInstagramHandle() { return instagramHandle; }
    public void setInstagramHandle(String instagramHandle) { this.instagramHandle = instagramHandle; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    // toString
    @Override
    public String toString() {
        return "PrideVO{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", tagsCsv='" + tagsCsv + '\'' +
                ", tags='" + tags + '\'' +
                ", instagramHandle='" + instagramHandle + '\'' +
                ", content='" + content + '\'' +
                '}';
    }
}
