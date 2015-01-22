# encoding: utf-8

require 'sinatra'
require 'sinatra/url_for'
require 'sinatra/static_assets'
require 'sinatra/flash'
require 'digest/sha2'


BREADCRUMBS = {


  #主导航--title_first
  #1 技术服务--technology_service
  technology_service: {url: '/technology_service', label: '技术服务', map: 'technology_service'},

    #附导航--title_second
    #11 整合分析--bioinformatics_integrate
    bioinformatics_integrate: {url: '/technology_service/bioinformatics_integrate', label: '多维组学整合分析', map: 'technology_service/bioinformatics_integrate'},
      microRNA_mRNA: {url: '/technology_service/bioinformatics_integrate/microRNA_mRNA', label: 'microRNA_mRNA整合分析方案', map: 'technology_service/bioinformatics_integrate/microRNA_mRNA'},
      microRNA_tran_prot: {url: '/technology_service/bioinformatics_integrate/microRNA_tran_prot', label: 'microRNA_tran_prot整合分析方案', map: 'technology_service/bioinformatics_integrate/microRNA_tran_prot'},
      microRNA_degr_tran: {url: '/technology_service/bioinformatics_integrate/microRNA_degr_tran', label: 'microRNA_degr_tran整合分析方案', map: 'technology_service/bioinformatics_integrate/microRNA_degr_tran'},
      tf_mRNA_microRNA: {url: '/technology_service/bioinformatics_integrate/tf_mRNA_microRNA', label: 'tf_mRNA_microRNA整合分析方案', map: 'technology_service/bioinformatics_integrate/tf_mRNA_microRNA'},
      meth_mRNA_microRNA: {url: '/technology_service/bioinformatics_integrate/meth_mRNA_microRNA', label: 'meth_mRNA_microRNA整合分析方案', map: 'technology_service/bioinformatics_integrate/meth_mRNA_microRNA'},
      meth_mRNA: {url: '/technology_service/bioinformatics_integrate/meth_mRNA', label: 'meth_mRNA整合分析方案', map: 'technology_service/bioinformatics_integrate/meth_mRNA'},
      lcnRNA_mRNA: {url: '/technology_service/bioinformatics_integrate/lcnRNA_mRNA', label: 'lcnRNA_mRNA整合分析方案', map: 'technology_service/bioinformatics_integrate/lcnRNA_mRNA'},
      prot_metab: {url: '/technology_service/bioinformatics_integrate/prot_metab', label: 'prot_metab整合分析方案', map: 'technology_service/bioinformatics_integrate/prot_metab'},
      tran_prot: {url: '/technology_service/bioinformatics_integrate/tran_prot', label: 'tran_prot整合分析方案', map: 'technology_service/bioinformatics_integrate/tran_prot'},
      exome_tran: {url: '/technology_service/bioinformatics_integrate/exome_tran', label: 'exome_tran整合分析方案', map: 'technology_service/bioinformatics_integrate/exome_tran'},
    
    #12 基因组--genomics
    genomics: {url: '/technology_service/genomics', label: '基因组学', map: 'technology_service/genomics'},
      genome_reseq: {url: '/technology_service/genomics/genome_reseq', label: '基因组重测序', map: 'technology_service/genomics/genome_reseq'},
      novo_seq: {url: '/technology_service/genomics/novo_seq', label: '基因组de novo测序', map: 'technology_service/genomics/novo_seq'},
      target_region_seq: {url: '/technology_service/genomics/target_region_seq', label: '目标区域捕获测序', map: 'technology_service/genomics/target_region_seq'},
      exome_seq: {url: '/technology_service/genomics/exome_seq', label: '外显子组测序', map: 'technology_service/genomics/exome_seq'},
      aCGH: {url: '/technology_service/genomics/aCGH', label: 'aCGH芯片', map: 'technology_service/genomics/aCGH'},
      snp: {url: '/technology_service/genomics/snp', label: 'SNP芯片', map: 'technology_service/genomics/snp'},
    
    #13 转录组--transcriptomics
    transcriptomics: {url: '/technology_service/transcriptomics', label: '转录组学', map: 'technology_service/transcriptomics'},
      rna_seq: {url: '/technology_service/transcriptomics/rna_seq', label: '转录组测序', map: 'technology_service/transcriptomics/rna_seq'},
      dge_seq: {url: '/technology_service/transcriptomics/dge_seq', label: '数字基因表达谱测序', map: 'technology_service/transcriptomics/dge_seq'},
      sRNA_seq: {url: '/technology_service/transcriptomics/sRNA_seq', label: 'sRNA测序', map: 'technology_service/transcriptomics/sRNA_seq'},
      lncRNA_seq: {url: '/technology_service/transcriptomics/lncRNA_seq', label: 'lncRNA测序', map: 'technology_service/transcriptomics/lncRNA_seq'},
      degradome_seq: {url: '/technology_service/transcriptomics/degradome_seq', label: '降解组测序', map: 'technology_service/transcriptomics/degradome_seq'},
      mRNA_chip: {url: '/technology_service/transcriptomics/mRNA_chip', label: '基因表达芯片', map: 'technology_service/transcriptomics/mRNA_chip'},
      microRNA_chip: {url: '/technology_service/transcriptomics/microRNA_chip', label: 'microRNA芯片', map: 'technology_service/transcriptomics/microRNA_chip'},
      lncRNA_chip: {url: '/technology_service/transcriptomics/lncRNA_chip', label: 'lncRNA芯片', map: 'technology_service/transcriptomics/lncRNA_chip'},
    
    #14 表观遗传组--epigenetics
    epigenetics: {url: '/technology_service/epigenetics', label: '表观遗传学', map: 'technology_service/epigenetics'},
      bisulfite_seq: {url: '/technology_service/epigenetics/bisulfite_seq', label: '全基因组bisulfite_seq', map: 'technology_service/epigenetics/bisulfite_seq'},
      rrbs: {url: '/technology_service/epigenetics/rrbs', label: '简化甲基化测序', map: 'technology_service/epigenetics/rrbs'},
      me_dip_seq: {url: '/technology_service/epigenetics/me_dip_seq', label: 'Me_DIP测序', map: 'technology_service/epigenetics/me_dip_seq'},
      chip_seq: {url: '/technology_service/epigenetics/chip_seq', label: 'ChIP_Seq', map: 'technology_service/epigenetics/chip_seq'},
      methyl_chip: {url: '/technology_service/epigenetics/methyl_chip', label: '甲基化芯片', map: 'technology_service/epigenetics/methyl_chip'},
      chip_chip: {url: '/technology_service/epigenetics/chip_chip', label: 'ChIP_chip', map: 'technology_service/epigenetics/chip_chip'},
    
    #15 宏基因组--microbiomics
    microbiomics: {url: '/technology_service/microbiomics', label: '宏基因组', map: 'technology_service/microbiomics'},
      macro_genome_seq: {url: '/technology_service/microbiomics/macro_genome_seq', label: '宏基因组测序', map: 'technology_service/microbiomics/macro_genome_seq'},
      microbial_reseq: {url: '/technology_service/microbiomics/microbial_reseq', label: '微生物基因组重测序', map: 'technology_service/microbiomics/microbial_reseq'},
      rDNA: {url: '/technology_service/microbiomics/rDNA', label: '16SrDNA测序', map: 'technology_service/microbiomics/rDNA'},
      microbial_tran: {url: '/technology_service/microbiomics/microbial_tran', label: '微生物转录组', map: 'technology_service/microbiomics/microbial_tran'},
    
    #16 蛋白质组--proteomics
    proteomics: {url: '/technology_service/proteomics', label: '蛋白质组学', map: 'technology_service/proteomics'},
      iTRAQ: {url: '/technology_service/proteomics/iTRAQ', label: 'iTRAQ蛋白质组', map: 'technology_service/proteomics/iTRAQ'},
      ms: {url: '/technology_service/proteomics/ms', label: 'LC/GC_MS', map: 'technology_service/proteomics/ms'},
      protein_modification: {url: '/technology_service/proteomics/protein_modification', label: '蛋白质修饰', map: 'technology_service/proteomics/protein_modification'},
    
    #17 代谢组学--metabonomics
    metabonomics: {url: '/technology_service/metabonomics', label: '代谢组学', map: 'technology_service/metabonomics'},
      nmr: {url: '/technology_service/metabonomics/nmr', label: 'NMR', map: 'technology_service/metabonomics/nmr'},
      ms: {url: '/technology_service/metabonomics/ms', label: 'LC/GC_MS', map: 'technology_service/metabonomics/ms'},

    #18 常规实验--experimental_service
    experimental_service: {url: '/technology_service/experimental_service', label: '常规实验', map: 'technology_service/experimental_service'},



  #2 技术服务--technology_service
  application_solution: {url: '/application_solution', label: '应用方案', map: 'application_solution'},

    #21 生物信息定制分析--bioinformatics_basic
    bioinformatics_basic: {url: '/application_solution/bioinformatics_basic', label: '生物信息定制分析', map: 'application_solution/bioinformatics_basic'},
        analysis: {url: '/application_solution/bioinformatics_basic/analysis', label: '基本分析', map: 'application_solution/bioinformatics_basic/analysis'},
        expression_data: {url: '/application_solution/bioinformatics_basic/expression_data', label: '表达数据基本分析', map: 'application_solution/bioinformatics_basic/expression_data'},
        other_data: {url: '/application_solution/bioinformatics_basic/other_data', label: '其他数据分析', map: 'application_solution/bioinformatics_basic/other_data'},
        cluster: {url: '/application_solution/bioinformatics_basic/cluster', label: '聚类分类', map: 'application_solution/bioinformatics_basic/cluster'},
        target_prediction: {url: '/application_solution/bioinformatics_basic/target_prediction', label: '靶标预测', map: 'application_solution/bioinformatics_basic/target_prediction'},
        function: {url: '/application_solution/bioinformatics_basic/function', label: '功能分析', map: 'application_solution/bioinformatics_basic/function'},
        network: {url: '/application_solution/bioinformatics_basic/network', label: '网络分析', map: 'application_solution/bioinformatics_basic/network'},

    #22 统计咨询分析--medica_statistics
    medica_statistics: {url: '/application_solution/medica_statistics', label: '统计咨询分析', map: 'application_solution/medica_statistics'},
 
    #23 论文修订编辑--paper_edit
    paper_edit: {url: '/application_solution/paper_edit', label: '论文修订编辑', map: 'application_solution/paper_edit'},

    #24 生物信息学培训--training
    training: {url: '/application_solution/training', label: '生物信息学培训', map: 'application_solution/training'},

    #25 数据库构建--database
    database: {url: '  /application_solution/database', label: '数据库构建', map: 'application_solution/database'},
 
    #26 BioMaker的发现与验证--biomarker
    biomarker: {url: '/application_solution/biomarker', label: 'BioMaker的发现与验证', map: 'application_solution/biomarker'},

  #3 关于我们--about_us
  about_us: {url: '/about_us/introduction', label: '公司简介', map: 'about_us/introduction'},
    culture: {url: '/about_us/culture', label: '公司文化', map: 'about_us/culture'},
    partners: {url: '/about_us/partners', label: '合作伙伴', map: 'about_us/partners'},
    intellectual_property: {url: '/about_us/intellectual_property', label: '知识产权', map: 'about_us/intellectual_property'},
    contact_us: {url: '/about_us/contact_us', label: '联系我们', map: 'about_us/contact_us'},


  news: {url: '/news', label: '新闻动态', map: 'news'},
    information: {url: '/news/information', label: '行业资讯', map: 'news/information'},
    meeting: {url: '/news/meeting', label: '会议介绍', map: 'news/meeting'},
    activity: {url: '/news/activity', label: '公司活动', map: 'news/activity'},


  recruitment: {url: '/recruitment', label: '招贤纳士', map: 'recruitment'},
    


}


#路径函数
helpers do
  def get_path_map
      path = request.path_info
      BREADCRUMBS.values.reverse.each do |route|
          if path =~ %r(#{route[:url]})
              return route[:map]
          end
      end

      return ''
  end

  def current_path
      path = []
      get_path_map.split('/').each do |part|
          part = part.to_sym
          if BREADCRUMBS.has_key?(part)
              route = BREADCRUMBS[part.to_sym]
              path << [route[:url], route[:label]]
          end
      end
      return path
  end

  def clean_tag(content)
      content.gsub(/\<\/?\w+\>/, '')
  end

end


#首页--home
get '/' do
  erb :index
end


#技术服务
get '/technology_service/?:type?/?:subtype?' do |type,subtype|
  if type.nil?
    @path = "/technology_service"
    erb :technology_service, :layout => :two_layout
  elsif subtype.nil?
    @path = "/technology_service/#{type}"
    erb :"technology_service/#{type}.htm.utf-8", :layout => :two_layout
  else
    @path = "/technology_service/#{type}/#{subtype}"
    erb :"technology_service/#{type}/#{subtype}.htm.utf-8", :layout => :three_layout
  end
end


#应用方案
get '/application_solution/?:type?/?:subtype?' do |type,subtype|
  if type.nil?
    @path = "/application_solution"
    erb :application_solution, :layout => :four_layout
  elsif subtype.nil?
    @path = "/application_solution/#{type}"
    erb :"application_solution/#{type}.htm.utf-8", :layout => :four_layout
  else
    @path = "/application_solution/#{type}/#{subtype}"
    erb :"application_solution/#{type}/#{subtype}.htm.utf-8", :layout => :four_layout
  end
end


#关于我们
get '/about_us/?:type?' do |type|
  if type.nil?
    @path = "/about_us"
    erb :about_us, :layout => :four_layout
  else
    @path = "/about_us/#{type}"
    erb :"about_us/#{type}.htm.utf-8", :layout => :four_layout
  end
end


#新闻动态
get '/news/?:type?' do |type|
  if type.nil?
    @path = "/news"
    erb :news
  else
    @path = "/news/#{type}"
    erb :"news/#{type}.htm.utf-8"
  end
end


#招贤纳士
get '/recruitment' do
  @path = "/recruitment"
   erb :recruitment, :layout => :four_layout
end


get '/a' do 
  erb :a
end

#找不到页面
not_found do
  erb :"#{env['REQUEST_URI']}.htm.utf-8", :layout => :three_layout
end


get '/sent_url' do 
  @url = params['url']
  # erb :'/technology_service/genomics'
  redirect to '/technology_service/genomics'
end


