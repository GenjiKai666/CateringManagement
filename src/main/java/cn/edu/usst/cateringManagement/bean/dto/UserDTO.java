package cn.edu.usst.cateringManagement.bean.dto;

import lombok.*;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
public class UserDTO {
    private Integer id;
    @Length(min = 1, max = 15, message = "用户名不合法，请不要超过15，也不要为空")
    private String name;
    @Length(min = 6, max = 25, message = "密码不合法，请不要超过25，也不要小于6")
    private String password;
    @Pattern(regexp = "^1[0-9]{10}$", message = "手机号不是11位的合法数字")
    private String phone;
}
