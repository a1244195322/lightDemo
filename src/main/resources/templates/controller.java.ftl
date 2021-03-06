package ${package.Controller};


import com.changfei.demo.common.constant.Constant;
import com.changfei.demo.common.page.PageData;
import com.changfei.demo.common.utils.Result;
import ${package.Entity}.${entity};
import ${package.Service}.${table.serviceName};
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.util.List;
import java.util.Map;

/**
* <p>
* ${table.comment!} 前端控制器
* </p>
*
* @author ${author}
* @since ${date}
*/
<#if restControllerStyle>
@RestController
<#else>
@Controller
</#if>
@RequestMapping("<#if package.ModuleName?? && package.ModuleName != "">/${package.ModuleName}</#if>/<#if controllerMappingHyphenStyle??>${controllerMappingHyphen}<#else>${table.entityPath}</#if>")
@Api(tags="")
<#if superControllerClass??>
public class ${table.controllerName} extends ${superControllerClass} {
<#else>
public class ${table.controllerName} {
</#if>

    @Autowired
    private ${table.serviceName} baseService;


    @ApiOperation("获取分页数据")
    @PostMapping("/getPageByMap")
    @ApiImplicitParams({
    @ApiImplicitParam(name = Constant.PAGE_NO, value = "当前页码", paramType = "query", dataType="String"),
    @ApiImplicitParam(name = Constant.LIMIT, value = "每页记录数", paramType = "query", dataType="String"),
    @ApiImplicitParam(name = Constant.ORDER_FIELD, value = "排序字段", paramType = "query", dataType="String"),
    @ApiImplicitParam(name = Constant.ORDER, value = "排序方式(asc desc)", paramType = "query", dataType="String")
    })
    public Result< PageData<${entity}>> getPageByMap(@ApiIgnore @RequestParam Map< String, Object> params) {
    PageData<${entity}> data=baseService.getPageByMap(params);
        return new Result< PageData<${entity}>>().ok(data);
    }

    @ApiOperation("保存")
    @PostMapping("/save")
    public Result<${entity}> save(${entity} entity){
        boolean b=baseService.saveOrUpdate(entity);
        if(b){
            return new Result<${entity}>().ok(entity);
        }
        return new Result<${entity}>().error("保存失败");
    }

    @ApiOperation("获取单条数据")
    @PostMapping("/get/{id}")
    public Result<${entity}> get(@PathVariable String id){
        ${entity} entity=baseService.getById(id);
        return new Result<${entity}>().ok(entity);
    }
}
